import 'package:store/features/cart/domain/entites/cart.dart';
import 'cart_item_model.dart';

class CartModel {
  final String cartId;
  final List<CartItemModel> cartItems;

  CartModel({required this.cartId, required this.cartItems});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartId: json['cartId'],
        cartItems: (json['cartItems'] as List)
            .map((e) => CartItemModel.fromJson(e))
            .toList(),
      );

  Cart toEntity() => Cart(
      cartId: cartId, cartItems: cartItems.map((e) => e.toEntity()).toList());
}
