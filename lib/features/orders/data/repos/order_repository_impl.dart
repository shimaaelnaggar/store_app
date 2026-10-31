import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';

import 'package:store/core/errors/failures.dart';
import 'package:store/core/errors/map_exception_to_failure.dart';

import 'package:store/features/orders/domain/entites/checkout_response.dart';
import 'package:store/features/orders/domain/entites/order.dart';

import '../../domain/repos/order_repository_contract.dart';
import '../data_sources/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepositoryContract {
  final BaseOrderRemoteDataSource dataSource;

  OrderRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, CheckOutResponse>> placeOrder(
      {required String shippingAddressId, String? couponCode}) async {
    try {
      final response = await dataSource.placeOrder(
          shippingAddressId: shippingAddressId, couponCode: couponCode);
      return Right(response);
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }
@override
Future<Either<Failure, List<OrderEntity>>> getOrders() async {
try {
final response = await dataSource.getOrders();
return Right(response);
} on AppException catch (exception) {
return Left(mapExceptionToFailure(exception));
}
}}
