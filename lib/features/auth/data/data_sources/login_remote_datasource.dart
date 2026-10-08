import 'package:dio/dio.dart';
import 'package:store/core/errors/api_error_handler.dart';
import 'package:store/features/auth/data/models/Login_response_model.dart';
import 'package:store/features/auth/data/models/login_model.dart';

abstract class BaseLoginRemoteDataSource {
  Future<LoginResponseModel> login(LoginModel login);
}

class LoginRemoteDataSource implements BaseLoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSource({required this.dio});

  @override
  Future<LoginResponseModel> login(LoginModel login) async {
    try {
      final response = await dio.post(
        '/api/auth/login',
        data: login.toJson(),
      );
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
