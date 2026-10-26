import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:store/features/cart/domain/entites/add_to_cart_response.dart';
import 'package:store/features/cart/domain/entites/cart.dart';

import '../../../../core/errors/map_exception_to_failure.dart';
import '../../domain/repos/cart_repository_contract.dart';

class AddToCartRepositoryImpl implements CartRepositoryContract {
  final BaseCartRemoteDataSource remoteDataSource;

  AddToCartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AddToCartResponse>> addToCart(
      {required String productId, required int quantity}) async {
    try {
      final response = await remoteDataSource.addToCart(
          productId: productId, quantity: quantity);
      return right(response.toEntity());
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      final response = await remoteDataSource.getCart();
      return right(response.toEntity());
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Unit>> decrementQuantity(
      {required String itemId, required int quantity}) async {
    try {
      await remoteDataSource.decrementQuantity(
          itemId: itemId, quantity: quantity);
      return right(unit);
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeItem({required String itemId}) async {
    try {
      await remoteDataSource.removeItem(itemId: itemId);
      return right(unit);
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQuantity(
      {required String itemId, required int quantity}) async {
    try {
      await remoteDataSource.updateQuantity(itemId: itemId, quantity: quantity);
      return right(unit);
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }
}
