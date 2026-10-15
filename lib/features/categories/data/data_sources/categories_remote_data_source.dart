import 'package:dio/dio.dart';
import '../../../../core/errors/api_error_handler.dart';
import '../models/category_model.dart';

abstract class BaseCategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoriesRemoteDataSource implements BaseCategoriesRemoteDataSource {
  final Dio dio;

  CategoriesRemoteDataSource({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get('/api/categories');
      final data = response.data as Map<String, dynamic>;
      final categories = data['categories'] as List;
      return categories
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
