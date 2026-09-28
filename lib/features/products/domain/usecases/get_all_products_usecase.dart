import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/products/domain/entites/products_result.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';

class GetAllProductsUseCase {
  final ProductRepositoryContract repository;

  GetAllProductsUseCase({required this.repository});

  Future<Either<Failure, ProductsResult>> execute(
      {required int page, required int pageSize, String? searchQuery}) {
    return repository.getAllProducts(
        page: page, pageSize: pageSize, searchQuery: searchQuery);
  }
}
