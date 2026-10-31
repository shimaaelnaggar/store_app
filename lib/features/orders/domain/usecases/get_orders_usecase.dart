import 'package:dartz/dartz.dart';
import 'package:store/features/orders/domain/repos/order_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entites/order.dart';

class GetOrdersUseCase {
  final OrderRepositoryContract repository;

  GetOrdersUseCase({required this.repository});

  Future<Either<Failure, List<OrderEntity>>> execute() {
    return repository.getOrders();
  }
}
