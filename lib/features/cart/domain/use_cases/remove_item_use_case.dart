import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';
import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/features/order/domain/repositories/order_repo.dart';

class RemoveItemUseCase {
  final CartRepo cartRepo;

  RemoveItemUseCase({required this.cartRepo});

  Future<void> execute({required String productId}) async {
    return cartRepo.removeItem(productId: productId);
  }
}
