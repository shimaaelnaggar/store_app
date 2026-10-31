import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class Cart extends Equatable {
  final String cartId;
  final List<CartItem> cartItems;

  const Cart({required this.cartId, required this.cartItems});

  int get totalQuantity => cartItems.fold(
        0,
        (total, item) => total + item.quantity,
      );
  @override
  List<Object?> get props => [cartId, cartItems];
}
