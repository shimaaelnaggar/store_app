import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store/core/errors/api_error_handler.dart';
import 'package:store/features/orders/data/models/checkout_response_model.dart';
import 'package:store/features/orders/data/models/order_model.dart';

abstract class BaseOrderRemoteDataSource {
  Future<CheckOutResponseModel> placeOrder(
      {required String shippingAddressId, String? couponCode});
  Future<List<OrderModel>> getOrders();
}

class OrderRemoteDataSource implements BaseOrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource({required this.dio});

  @override
  Future<CheckOutResponseModel> placeOrder(
      {required String shippingAddressId, String? couponCode}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/api/orders/checkout',
        data: {
          'shippingAddressId': shippingAddressId,
          'couponCode': couponCode,
          'paymentMethod': 'Paymob',
        },
      );
      debugPrint('Checkout status: ${response.statusCode}');
      debugPrint('Checkout response: ${response.data}');
      return CheckOutResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiErrorHandler().handle(e);
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/api/orders',
      );

      debugPrint('Orders status: ${response.statusCode}');

      final ordersJson = response.data!['orders'] as List;

      return ordersJson
          .map(
            (order) => OrderModel.fromJson(
          order as Map<String, dynamic>,
        ),
      )
          .toList();
    } on DioException catch (e) {
      throw ApiErrorHandler().handle(e);
    }
  }
}
