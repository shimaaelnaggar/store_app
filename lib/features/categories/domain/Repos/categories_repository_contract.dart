import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category.dart';

abstract class CategoriesRepositoryContract {
  Future<Either<Failure, List<Category>>> getCategories();
}
