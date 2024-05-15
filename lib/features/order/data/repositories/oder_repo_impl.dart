import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/features/order/domain/repositories/order_repo.dart';
import 'package:talabatee/services/database.dart';

class OrderRepoImpl extends OrderRepo {
  @override
  Future<List<Categories>> getCategories() async {
    try {
      final categories = await DB.getCategories();
      return categories;
    } catch (e) {
      rethrow; // Rethrow the error for now
    }
  }

  @override
  Future<List<Product>> getProductsByCategoryId(
      {required String categoryId}) async {
    try {
      final products = await DB.getProductByCategoryId(
          categoryId:
              categoryId); // Assuming you have a method in DB class to get products
      return products;
    } catch (e) {
      rethrow; // Rethrow the error for now
    }
  }
}
