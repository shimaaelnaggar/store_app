import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class Cart extends Equatable {
  final String cartId;
  final List<CartItem> cartItems;

  const Cart({required this.cartId, required this.cartItems});
  @override
  List<Object?> get props => [cartId, cartItems];
}
