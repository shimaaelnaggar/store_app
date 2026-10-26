import 'package:dio/dio.dart';
import 'package:store/features/cart/data/models/add_to_cart_response_model.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../models/cart_model.dart';

abstract class BaseCartRemoteDataSource {
  Future<AddToCartResponseModel> addToCart(
      {required String productId, required int quantity});

  Future<CartModel> getCart();
  Future<void> decrementQuantity(
      {required String itemId, required int quantity});
  Future<void> removeItem({required String itemId});
  Future<void> updateQuantity({required String itemId, required int quantity});
}

class CartRemoteDataSource implements BaseCartRemoteDataSource {
  final Dio dio;

  CartRemoteDataSource({required this.dio});

  @override
  Future<AddToCartResponseModel> addToCart(
      {required String productId, required int quantity}) async {
    try {
      final response = await dio.post('/api/cart/items', data: {
        'productId': productId,
        'quantity': quantity,
      });
      return AddToCartResponseModel.fromJson(response.data);
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<CartModel> getCart() async {
    try {
      final response = await dio.get('/api/cart');
      return CartModel.fromJson(response.data);
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<void> decrementQuantity(
      {required String itemId, required int quantity}) async {
    try {
      await dio.post('/api/cart/items/decrement', data: {
        'itemId': itemId,
        'quantity': quantity,
      });
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<void> removeItem({required String itemId}) async {
    try {
      await dio.delete('/api/cart/items/$itemId');
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<void> updateQuantity(
      {required String itemId, required int quantity}) async {
    try {
      await dio.put(
        '/api/cart/items/$itemId',
        data: {'quantity': quantity},
      );
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
