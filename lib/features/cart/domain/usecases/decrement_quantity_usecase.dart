import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repos/cart_repository_contract.dart';

class DecrementQuantityUseCase {
  final CartRepositoryContract repository;

  DecrementQuantityUseCase({required this.repository});

  Future<Either<Failure, Unit>> execute(
      {required String itemId, required int quantity}) {
    return repository.decrementQuantity(itemId: itemId, quantity: quantity);
  }
}
