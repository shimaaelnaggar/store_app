import 'package:store/features/cart/domain/entites/cart_item.dart';

class CartItemModel {
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

  const CartItemModel({
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

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        itemId: json['itemId'] as String,
        productId: json['productId'] as String,
        productName: json['productName'] as String,
        productCoverUrl: json['productCoverUrl'] as String,
        productStock: json['productStock'] as int,
        quantity: json['quantity'] as int,
        basePricePerUnit: (json['basePricePerUnit'] as num).toDouble(),
        discountPercentage: (json['discountPercentage'] as num).toDouble(),
        finalPricePerUnit: (json['finalPricePerUnit'] as num).toDouble(),
        totalPrice: (json['totalPrice'] as num).toDouble(),
        weightInGrams: (json['weightInGrams'] as num).toDouble(),
      );

  CartItem toEntity() => CartItem(
        itemId: itemId,
        productId: productId,
        productName: productName,
        productCoverUrl: productCoverUrl,
        productStock: productStock,
        quantity: quantity,
        basePricePerUnit: basePricePerUnit,
        discountPercentage: discountPercentage,
        finalPricePerUnit: finalPricePerUnit,
        totalPrice: totalPrice,
        weightInGrams: weightInGrams,
      );
}
