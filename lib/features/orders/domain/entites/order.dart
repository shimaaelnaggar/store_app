import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String orderId;
  final String orderCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final double totalPrice;
  final String paymentMethod;

  const OrderEntity({
    required this.orderId,
    required this.orderCode,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.totalPrice,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        orderId,
        orderCode,
        createdAt,
        updatedAt,
        status,
        totalPrice,
        paymentMethod,
      ];
}
