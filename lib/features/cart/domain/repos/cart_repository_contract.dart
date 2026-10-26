import 'package:dartz/dartz.dart';
import 'package:store/features/cart/domain/entites/add_to_cart_response.dart';
import 'package:store/features/cart/domain/entites/cart.dart';

import '../../../../core/errors/failures.dart';

abstract class CartRepositoryContract {
  Future<Either<Failure, AddToCartResponse>> addToCart(
      {required String productId, required int quantity});

  Future<Either<Failure, Cart>> getCart();

  Future<Either<Failure, Unit>> updateQuantity(
      {required String itemId, required int quantity});

  Future<Either<Failure, Unit>> removeItem({required String itemId});

  Future<Either<Failure, Unit>> decrementQuantity(
      {required String itemId, required int quantity});
}
