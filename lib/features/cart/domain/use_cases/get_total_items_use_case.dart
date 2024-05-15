import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';
import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/features/order/domain/repositories/order_repo.dart';

class GetItemsUseCase {
  final CartRepo cartRepo;

  GetItemsUseCase({required this.cartRepo});

  int execute()  {
    return cartRepo.items.length;
  }
}
