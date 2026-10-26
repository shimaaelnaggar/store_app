import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repos/cart_repository_contract.dart';

class RemoveCartItemUseCase {
  final CartRepositoryContract repository;

  RemoveCartItemUseCase({required this.repository});

  Future<Either<Failure, Unit>> execute({required String itemId}) {
    return repository.removeItem(itemId: itemId);
  }
}
