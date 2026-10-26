import '../../domain/entites/add_to_cart_response.dart';

class AddToCartResponseModel {
  final String? id;
  final String? productId;
  final String message;
  final int quantity;

  AddToCartResponseModel(
      {required this.id,
      required this.productId,
      required this.message,
      required this.quantity});

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) =>
      AddToCartResponseModel(
          id: json['id'],
          productId: json['productId'],
          message: json['message'],
          quantity: json['quantity']);

  AddToCartResponse toEntity() => AddToCartResponse(
      id: id, productId: productId, message: message, quantity: quantity);
}
