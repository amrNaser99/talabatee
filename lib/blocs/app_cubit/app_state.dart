import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class GetCategoriesLoading extends AppState {}

class GetCategoriesSuccess extends AppState {
  final List<Categories> categories;

  GetCategoriesSuccess({required this.categories});

  @override
  String toString() {
    return 'GetCategoriesSuccess{categories: $categories}';
  }
}

class GetCategoriesFailed extends AppState {
  final String error;

  GetCategoriesFailed({required this.error});

  @override
  String toString() {
    return 'GetCategoriesFailed{error: $error}';
  }
}

class GetProductByCategoriesIdLoading extends AppState {}

class GetProductByCategoriesIdSuccess extends AppState {
  final List<Product> products;
  final String categoryId;

  GetProductByCategoriesIdSuccess({required this.products,required this.categoryId});

  @override
  String toString() {
    return 'GetProductByCategoriesIdSuccess{products: $products}';
  }
}

class GetProductByCategoriesIdFailed extends AppState {
  final String error;

  GetProductByCategoriesIdFailed({required this.error});

  @override
  String toString() {
    return 'GetProductByCategoriesIdFailed{error: $error}';
  }
}
