import 'package:talabatee/features/cart/domain/entities/cart_item.dart';

class CartState {
  final Map<String, CartItem> items;
  final double totalPrice;

  CartState({required this.items, required this.totalPrice});

  factory CartState.initial() {
    return CartState(items: {}, totalPrice: 0.0);
  }
  CartState update({Map<String, CartItem>? items, double? totalPrice}) {
    return CartState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );

  }

  @override
  String toString() {
    return 'CartState{items: $items, totalPrice: $totalPrice}';
  }

}
