import 'package:dartz/dartz.dart';
import 'package:store/features/orders/domain/entites/order.dart';


import '../../../../core/errors/failures.dart';
import '../entites/checkout_response.dart';

abstract class OrderRepositoryContract {
  Future<Either<Failure, CheckOutResponse>> placeOrder({
    required String shippingAddressId,
    String? couponCode,
  });

  Future<Either<Failure, List<OrderEntity>>> getOrders();
}
