import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabatee/features/cart/domain/use_cases/add_item_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/get_total_items_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/get_total_price_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/remove_item_use_case.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_state.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';

class CartCubit extends Cubit<CartState> {
  final AddItemUseCase addItemUseCase;
  final RemoveItemUseCase removeItemUseCase;
  final ClearCartUseCase clearCartUseCase;
  final GetTotalPriceUseCase getTotalPriceUseCase;
  final GetItemsUseCase getItemsUseCase;

  CartCubit({
    required this.addItemUseCase,
    required this.removeItemUseCase,
    required this.clearCartUseCase,
    required this.getTotalPriceUseCase,
    required this.getItemsUseCase,
  }) : super(CartState.initial());

  void addItem(Product product) async {
    try {

      await addItemUseCase.execute(product: product);
      double newTotal = await getTotalPriceUseCase.execute();
      emit(state.update(totalPrice: newTotal));
    } catch (error) {
      log('Failed to add item: $error');
    }
  }

  void removeItem(String productId) async {
    try {
      await removeItemUseCase.execute(productId: productId);
      double newTotal = await getTotalPriceUseCase.execute();
      emit(state.update(totalPrice: newTotal));
    } catch (error) {
      log('Failed to remove item: $error');
    }
  }

  void checkout() async {
    try {
      double totalPrice = await getTotalPriceUseCase.execute();
      log("Checking out with total price: $totalPrice");
      await clearCartUseCase.execute();
      emit(CartState.initial());
    } catch (error) {
      log('Checkout failed: $error');
    }
  }

  int getItems()  {
    try {
      int itemsCount =  getItemsUseCase.execute();
      CartState.initial();
      return itemsCount;
      } catch (error) {
      log('Checkout failed: $error');
      return 0;
    }
  }
}
