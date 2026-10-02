import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/categories/domain/entities/category.dart';
import '../../domain/Repos/categories_repository_contract.dart';
import '../data_sources/categories_remote_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepositoryContract {
  final BaseCategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();

      return right(
        categories.map((e) => e.toEntity()).toList(),
      );
    } on AppException catch (exception) {
      if (exception is ServerException) {
        return Left(
          ServerFailure(
            errorMessage: exception.errorMessage,
          ),
        );
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
