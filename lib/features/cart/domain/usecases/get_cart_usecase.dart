import 'package:dartz/dartz.dart';
import 'package:store/features/cart/domain/repos/cart_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entites/cart.dart';

class GetCartUseCase {
  final CartRepositoryContract repository;

  GetCartUseCase({required this.repository});

  Future<Either<Failure, Cart>> execute() {
    return repository.getCart();
  }
}
