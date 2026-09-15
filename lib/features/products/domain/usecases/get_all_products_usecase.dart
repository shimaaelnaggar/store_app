import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/products/domain/entites/product.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';

class GetAllProductsUseCase {
  final ProductRepositoryContract repository;

  GetAllProductsUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> execute() {
    return repository.getAllProducts();
  }
}
