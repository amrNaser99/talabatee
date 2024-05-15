import 'package:flutter/foundation.dart';
import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';

abstract class OrderRepo {
  Future<List<Categories>> getCategories();

  Future<List<Product>> getProductsByCategoryId({required String categoryId});
}
