import 'package:dartz/dartz.dart';
import 'package:store/features/cart/domain/repos/cart_repository_contract.dart';

import '../../../../core/errors/failures.dart';

class UpdateQuantityUseCase {
  final CartRepositoryContract repository;

  UpdateQuantityUseCase({required this.repository});

  Future<Either<Failure, Unit>> execute(
      {required String itemId, required int quantity}) {
    return repository.updateQuantity(itemId: itemId, quantity: quantity);
  }
}
