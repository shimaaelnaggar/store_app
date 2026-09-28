import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:store/features/products/domain/entites/products_result.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';

class ProductsRepositoryImplementation implements ProductRepositoryContract {
  final BaseProductsRemoteDataSource dataSource;

  ProductsRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, ProductsResult>> getAllProducts(
      {required int page, required int pageSize, String? searchQuery}) async {
    try {
      final response = await dataSource.getAllProducts(
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery,
      );
      return right(ProductsResult(
          products:
              response.items.map((element) => element.toEntity()).toList(),
          page: response.page,
          pageSize: response.pageSize,
          totalCount: response.totalCount,
          hasNextPage: response.hasNextPage,
          hasPreviousPage: response.hasPreviousPage));
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
