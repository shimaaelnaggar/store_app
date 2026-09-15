import 'package:dio/dio.dart';
import 'package:store/core/errors/api_error_handler.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/features/products/data/models/product_model.dart';

abstract class BaseProductsRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  // Future<ProductModel> getSingleProduct(int id);
  // Future<ProductModel> addNewProduct(ProductModel product);
  // Future<ProductModel> updateProduct(ProductModel product);
  // Future<void> deleteProduct(int id);
}

class ProductsRemoteDataSource implements BaseProductsRemoteDataSource {
  // @override
  // Future<ProductModel> addNewProduct(ProductModel product) {}

  // @override
  // Future<void> deleteProduct(int id) {}

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await DioClient.dio.get('products');

      return (response.data as List)
          .map((element) => ProductModel.fromJson(element))
          .toList();
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

