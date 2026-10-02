import 'package:dartz/dartz.dart';
import 'package:store/features/categories/domain/Repos/categories_repository_contract.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category.dart';

class GetCategoriesUseCase {
  final CategoriesRepositoryContract repository;
  GetCategoriesUseCase({required this.repository});
  Future<Either<Failure, List<Category>>> execute() async {
    return await repository.getCategories();
  }
}
