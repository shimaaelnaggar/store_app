import 'package:equatable/equatable.dart';

class AddToCartResponse extends Equatable {
  final String? id;
  final String? productId;
  final String message;
  final int quantity;

  const AddToCartResponse(
      {required this.id,
      required this.productId,
      required this.message,
      required this.quantity});

  @override
  List<Object?> get props => [id, productId, message, quantity];
}
