import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:store/features/products/data/models/product_model.dart';
import 'package:store/features/products/domain/entites/product.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';

class ProductsRepositoryImplementation implements ProductRepositoryContract {
  final BaseProductsRemoteDataSource dataSource;

  ProductsRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      List<ProductModel> products = await dataSource.getAllProducts();
      return right(products.map((product) => product.toEntity()).toList());
    } on AppException catch (exception) {
      if (exception is ServerException) {
        return Left(ServerFailure(
          errorMessage: exception.errorMessage,
        ));
      }
      if (exception is NetworkException) {
        return Left(
          NetworkFailure(
            errorMessage: exception.errorMessage,
          ),
        );
      }

      if (exception is TimeOutException) {
        return Left(
          TimeoutFailure(
            errorMessage: exception.errorMessage,
          ),
        );
      }
      return Left(
        UnknownFailure(
          errorMessage: exception.errorMessage,
        ),
      );
    }
  }
}
