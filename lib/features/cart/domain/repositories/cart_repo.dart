import 'package:talabatee/features/cart/domain/entities/cart_item.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';

abstract class CartRepo {
  Map<String, CartItem> get items;
  void addItem({required Product product});
  void removeItem({required String productId});
  double getTotalPrice();
  void clearCart();
}
