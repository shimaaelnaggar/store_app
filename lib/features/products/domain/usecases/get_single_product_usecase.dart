import 'package:dartz/dartz.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entites/product.dart';

class GetSingleProductUseCase {
  final ProductRepositoryContract repository;

  GetSingleProductUseCase({required this.repository});

  Future<Either<Failure, Product>> execute({required String id}) {
    return repository.getSingleProduct(id);
  }
}
