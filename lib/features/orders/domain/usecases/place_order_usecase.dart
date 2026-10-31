import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/orders/domain/entites/checkout_response.dart';
import 'package:store/features/orders/domain/repos/order_repository_contract.dart';

class PlaceOrderUseCase {
  final OrderRepositoryContract repository;

  PlaceOrderUseCase({required this.repository});

  Future<Either<Failure, CheckOutResponse>> execute({
    required String shippingAddressId,
    String? couponCode,
  }) {
    return repository.placeOrder(
      shippingAddressId: shippingAddressId,
      couponCode: couponCode,
    );
  }
}
