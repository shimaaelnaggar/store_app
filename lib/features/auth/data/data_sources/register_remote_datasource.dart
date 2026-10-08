import 'package:dio/dio.dart';
import 'package:store/features/auth/data/models/register_model.dart';

import '../../../../core/errors/api_error_handler.dart';

abstract class BaseRegisterRemoteDataSource {
  Future<void> createAccount(RegisterModel registerModel);
}

class RegisterRemoteDataSource implements BaseRegisterRemoteDataSource {
  final Dio dio;

  RegisterRemoteDataSource({required this.dio});
  @override
  Future<void> createAccount(RegisterModel registerModel) async {
    try {
      await dio.post(
        '/api/auth/register',
        data: registerModel.toJson(),
      );
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
