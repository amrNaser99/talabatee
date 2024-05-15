import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';

class ClearCartUseCase {
  final CartRepo cartRepo;

  ClearCartUseCase({required this.cartRepo});

  Future<void> execute() async {
    return cartRepo.clearCart();
  }
}
