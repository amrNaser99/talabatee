import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';
import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/features/order/domain/repositories/order_repo.dart';

class AddItemUseCase {
  final CartRepo cartRepo;

  AddItemUseCase({required this.cartRepo});

  Future<void> execute({required Product product}) async {
    return cartRepo.addItem(product: product);
  }
}
