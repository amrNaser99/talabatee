
import 'dart:developer';

import 'package:talabatee/core/utils/exceptions.dart';
import 'package:talabatee/features/cart/domain/entities/cart_item.dart';
import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';

class CartRepoImpl implements CartRepo {
  final Map<String, CartItem> _items = {};

  @override
  Map<String, CartItem> get items => {..._items};

  @override
  void addItem({required Product product}) {
    try {
      if (_items.containsKey(product.id.toString())) {
        _items.update(
          product.id.toString(),
              (existing) => CartItem(
              product: existing.product, quantity: existing.quantity + 1),

        );
        log("_items ${_items}");
      } else {
        _items[product.id.toString()] = CartItem(product: product, quantity: 1);
        log("_items ${_items}");

      }
    } catch (e) {
      throw QuantityUpdateException('Failed to add item: ${e.toString()}');
    }
  }

  @override
  void removeItem({required String productId}) {
    if (!_items.containsKey(productId)) {
      throw ItemNotFoundException(productId);
    }
    if (_items[productId]!.quantity > 1) {
      try {
        _items.update(
          productId,
              (existing) => CartItem(
              product: existing.product, quantity: existing.quantity - 1),
        );
      } catch (e) {
        throw QuantityUpdateException('Failed to update quantity: ${e.toString()}');
      }
    } else {
      _items.remove(productId);
    }
  }

  @override
  double getTotalPrice() {
    try {
      return _items.values
          .fold(0.0, (total, current) => total + current.totalPrice);
    } catch (e) {
      throw CartException('Failed to calculate total price: ${e.toString()}');
    }
  }

  @override
  void clearCart() {
    try {
      _items.clear();
    } catch (e) {
      throw CartException('Failed to clear cart: ${e.toString()}');
    }
  }
}
