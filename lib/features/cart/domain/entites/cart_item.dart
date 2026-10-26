import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String itemId;
  final String productId;
  final String productName;
  final String productCoverUrl;
  final int productStock;
  final int quantity;
  final double basePricePerUnit;
  final double discountPercentage;
  final double finalPricePerUnit;
  final double totalPrice;
  final double weightInGrams;

  const CartItem({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.productCoverUrl,
    required this.productStock,
    required this.quantity,
    required this.basePricePerUnit,
    required this.discountPercentage,
    required this.finalPricePerUnit,
    required this.totalPrice,
    required this.weightInGrams,
  });

  @override
  List<Object?> get props => [
        itemId,
        productId,
        productName,
        productCoverUrl,
        productStock,
        quantity,
        basePricePerUnit,
        discountPercentage,
        finalPricePerUnit,
        totalPrice,
        weightInGrams,
      ];
}
