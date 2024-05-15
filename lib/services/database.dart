import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talabatee/core/utils/exceptions.dart';
import 'package:talabatee/features/order/data/models/categories_model.dart';
import 'package:talabatee/features/order/data/models/product_model.dart';
import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:uuid/uuid.dart';

class DB {
  static final DB instance = DB._init();
  static Database? _database;

  DB._init();

  factory DB() => instance;

  static const _databaseName = 'local_db.db';

  static String createId() => md5
      .convert(
        utf8.encode(
          const Uuid().v1() +
              (DateTime.now().millisecondsSinceEpoch.toString()),
        ),
      )
      .toString();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static String? latestVersion;
  static String? installedVersion;

  Future<Database> initDB() async {
    debugPrint('----------initDB----------');

    // debugPrint('latestVersion ${latestVersion}');
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data =
          await rootBundle.load(join('assets/database', _databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(
      path,
      version: int.tryParse(installedVersion ?? '1'),
      // onCreate: _createDB,
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  /// Getting CategoryID for Item
  Future<String?> getCategoryIDForItem(String id) async {
    final db = await DB.instance.database;
    final response = await db.query(
      tableProduct,
      columns: ProductsFields.all,
      where: '${ProductsFields.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (response.isEmpty) {
      return null;
    }
    return response.first["CategoryID"] as String;
  }

  Future<bool> deleteByID({
    required String table,
    required String Id,
  }) async {
    log("in deleteByID : id is $Id");
    final db = await instance.database;
    final res = await db.delete(table, where: 'ID = ?', whereArgs: [Id]);
    if (res == 0) {
      throw const DBException('DB delete Error');
    }
    return res == 1 ? true : false;
  }

  Future<List<Product>?> getProducts({required BuildContext context}) async {
    final db = await instance.database;
    final response = await db.query(
      tableProduct,
      columns: ProductsFields.all,
    );

    if (response.isEmpty) {
      throw const DBException('noProducts');
    }

    // debugPrint('-------------------');
    return response.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getProductById(
      {required String id, bool? isDummy}) async {
    final db = await instance.database;
    final response = await db.query(tableProduct,
        columns: ProductsFields.all,
        where: '${ProductsFields.id} = ?',
        whereArgs: [id]);
    if (response.isEmpty) {
      throw const DBException('noProducts');
    }

    return response.first;
  }

  /// Generic methods

  Future<void> insert(String table, Map<String, dynamic> values) async {
    final db = await instance.database;
    await db.insert(table, values).then((value) {}).catchError((error) {});
    // if (res == 0) {
    //   throw const DBException('DB Insert Error');
    // }
  }

  Future<List<Map<String, dynamic>>> get(String query) async {
    final db = await instance.database;
    return db.rawQuery(query);
  }

  Future<Batch> get batch async =>
      Future.value((await instance.database).batch());

  Future<int> update(String table, Map<String, dynamic> values) async {
    final db = await instance.database;

    return await db
        .update(table, values, where: 'ID = ?', whereArgs: [values['ID']]);
  }

  Future<bool> delete(String table, Map<String, dynamic> values) async {
    final db = await instance.database;
    final res =
        await db.delete(table, where: 'ID = ?', whereArgs: [values['ID']]);
    if (res == 0) {
      throw const DBException('DB delete Error');
    }
    return res == 0 ? false : true;
  }

  /// reset database Tables
  Future<void> dropDBTable(String table) async {
    final db = await instance.database;

    // Delete the table
    await db.execute('DROP TABLE IF EXISTS $table').then((value) {
      debugPrint('$table DB Dropped Successfully');
    }).catchError((error) {
      debugPrint('$table DB Dropped Failed ${error.toString()}');
    });
  }

  /// reset database Tables
  Future<void> clearDBTable(String table) async {
    final db = await instance.database;

    // Delete the table
    await db.execute('delete from $table').then((value) {
      debugPrint('$table DB Dropped Successfully');
    }).catchError((error) {
      debugPrint('$table DB Dropped Failed ${error.toString()}');
    });
  }

  /// reset database Tables
  Future<bool> deleteTableDatabase(String table) async {
    final db = await instance.database;
    final result = await db.delete(table);
    return result > 0;
  }

  Future<void> createItemsDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Items (
        ID TEXT,
        Name_ar TEXT,
        Name_en TEXT,
        CategoryID TEXT,
        Price REAL,
        Image TEXT,
        Stock INTEGER,
        ItemDiscount REAL,
        BrandID TEXT,
        Barcode TEXT,
        Description_ar TEXT,
        Description_en TEXT,
        FOREIGN KEY (BrandID) REFERENCES Items_Brand (ID),
        FOREIGN KEY (CategoryID) REFERENCES Items_Categories (ID),
        PRIMARY KEY (ID)
      )
    ''');
  }

  Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert('Items', item);
  }

  Future<List<Map<String, dynamic>>> getAllData({
    required String stringTable,
  }) async {
    final db = await database;
    final dbResponse = await db.query(stringTable);
    return dbResponse;
  }

  Future<void> insertData(String tableName, List table) async {
    final Database db = await instance.database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final row in table) {
        batch.insert(
          tableName, row.toJson(),
          conflictAlgorithm: ConflictAlgorithm
              .replace, // Handles conflicts by replacing old data
        );
      }
      await batch.commit();
    });
  }

  Future<void> truncateTable(String tableName) async {
    final Database db = await instance.database;
    await db.delete(tableName);
  }

  static Future<List<Categories>> getCategories() async {
    final db = await instance.database;
    final response = await db.query(
      tableCategories,
      columns: CategoriesFields.all,
    );

    if (response.isEmpty) {
      throw const DBException('noCategories');
    }

    // debugPrint('-------------------');
    return response.map((e) => CategoriesModel.fromJson(e)).toList();
  }

  static Future<List<Product>> getProductByCategoryId(
      {required String categoryId}) async {
    final db = await instance.database;
    final response = await db.query(
      tableProduct, // Assuming 'Items' is the table name for products
      columns: ProductsFields.all,
      // Assuming ProductsFields.all contains column names
      where: '${ProductsFields.catId} = ?',
      // Filtering by category ID
      whereArgs: [categoryId], // Passing category ID as a parameter
    );

    if (response.isEmpty) {
      throw const DBException('noProducts');
    }

    return response.map((e) => ProductModel.fromJson(e)).toList();
  }
}
