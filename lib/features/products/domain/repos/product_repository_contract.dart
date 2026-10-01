import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/products/domain/entites/products_result.dart';

import '../entites/product.dart';

abstract class ProductRepositoryContract {
  Future<Either<Failure, ProductsResult>> getAllProducts(
  {required int page, required int pageSize, String? searchQuery}
      );
  Future <Either<Failure,Product>> getSingleProduct(String id);
}
