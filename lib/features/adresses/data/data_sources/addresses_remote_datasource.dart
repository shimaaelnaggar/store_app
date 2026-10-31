import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/core/errors/api_error_handler.dart';
import 'package:store/features/adresses/data/models/addresses_model.dart';

abstract class BaseAddressesRemoteDataSource {
  Future<List<AddressesModel>> getAddresses();
  Future<AddressesModel> addAddress(AddressesModel address);
  Future<AddressesModel> updateAddress(AddressesModel address);
  Future<void> deleteAddress(String id);
}

class AddressRemoteDataSource implements BaseAddressesRemoteDataSource {
  final Dio dio;

  AddressRemoteDataSource({required this.dio});
  @override
  Future<AddressesModel> addAddress(AddressesModel address) async {
    try {
      final response = await dio.post('/api/addresses', data: address.toJson());
      return AddressesModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Address status: ${e.response?.statusCode}');
      debugPrint('Address error body: ${e.response?.data}');
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await dio.delete('/api/addresses/$id');
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<List<AddressesModel>> getAddresses() async {
    try {
      final response = await dio.get('/api/addresses');
      return (response.data as List)
          .map((e) => AddressesModel.fromJson(e))
          .toList();
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<AddressesModel> updateAddress(AddressesModel address) async {
    try {
      final response =
          await dio.put('/api/addresses/${address.id}', data: address.toJson());
      return AddressesModel.fromJson(response.data);
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
