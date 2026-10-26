import 'package:dartz/dartz.dart';
import 'package:store/features/cart/domain/repos/cart_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entites/add_to_cart_response.dart';

class AddToCartUseCase {
  final CartRepositoryContract repository;

  AddToCartUseCase({required this.repository});

  Future<Either<Failure, AddToCartResponse>> execute(
      {required String productId, required int quantity}) {
    return repository.addToCart(productId: productId, quantity: quantity);
  }
}
