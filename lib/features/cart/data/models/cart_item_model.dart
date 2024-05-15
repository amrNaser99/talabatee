import 'package:talabatee/features/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({required super.product, required super.quantity});


  // factory CartItemModel.fromJson(Map<String, dynamic> json) {
  //   return CartItemModel(
  //     product: json[ProductsFields.id],
  //     quantity:
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //
  //   };
  // }
}
