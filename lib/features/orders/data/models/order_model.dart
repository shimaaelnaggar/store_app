import '../../domain/entites/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required String orderId,
    required String orderCode,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String status,
    required double totalPrice,
    required String paymentMethod,
  }) : super(
          orderId: orderId,
          orderCode: orderCode,
          createdAt: createdAt,
          updatedAt: updatedAt,
          status: status,
          totalPrice: totalPrice,
          paymentMethod: paymentMethod,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      orderCode: json['orderCode'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
    );
  }
}
