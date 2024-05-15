import 'package:equatable/equatable.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';

class CartItem extends Equatable {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double get totalPrice => quantity * product.price;

  @override
  List<Object> get props => [product];
}
