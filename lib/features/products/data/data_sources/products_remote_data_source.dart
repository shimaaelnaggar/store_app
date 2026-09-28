import 'package:dio/dio.dart';
import 'package:store/core/errors/api_error_handler.dart';
import 'package:store/features/products/data/models/products_recponse_model.dart';

abstract class BaseProductsRemoteDataSource {
  Future<ProductsResponseModel> getAllProducts(
      {required int page, required int pageSize, String? searchQuery});
  // Future<ProductModel> getSingleProduct(int id);
  // Future<ProductModel> addNewProduct(ProductModel product);
  // Future<ProductModel> updateProduct(ProductModel product);
  // Future<void> deleteProduct(int id);
}

class ProductsRemoteDataSource implements BaseProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSource({required this.dio});
  // @override
  // Future<ProductModel> addNewProduct(ProductModel product) {}

  // @override
  // Future<void> deleteProduct(int id) {}

  @override
  Future<ProductsResponseModel> getAllProducts({
    required int page,
    required int pageSize,
    String? searchQuery,
  }) async {
    try {
      final response = await dio.get(
        '/api/products',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'searchTerm': searchQuery
        },
      );

      return ProductsResponseModel.fromJson(response.data);
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}

// @override
// Future<ProductModel> getSingleProduct(int id) {

// }

// @override
// Future<ProductModel> updateProduct(ProductModel product) {}
