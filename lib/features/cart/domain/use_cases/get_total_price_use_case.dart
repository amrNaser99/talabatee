import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';

class GetTotalPriceUseCase {
  final CartRepo cartRepo;

  GetTotalPriceUseCase({required this.cartRepo});

  Future<double> execute() async {
    return cartRepo.getTotalPrice();
  }
}
