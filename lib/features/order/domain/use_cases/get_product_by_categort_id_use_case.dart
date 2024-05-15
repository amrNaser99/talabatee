import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/features/order/domain/repositories/order_repo.dart';

class GetProductByCategoryIdUseCase {
  final OrderRepo orderRepo;

  GetProductByCategoryIdUseCase({required this.orderRepo});

  Future<List<Product>> execute({required String categoryId}) async {
    return orderRepo.getProductsByCategoryId(categoryId: categoryId);
  }
}
