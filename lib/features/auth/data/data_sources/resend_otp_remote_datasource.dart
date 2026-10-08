import 'package:dio/dio.dart';

import '../../../../core/errors/api_error_handler.dart';

abstract class BaseResendOtpRemoteDataSource {
  Future<void> resendOtp(String email);
}

class ResendOtpRemoteDataSource implements BaseResendOtpRemoteDataSource {
  final Dio dio;

  ResendOtpRemoteDataSource({required this.dio});

  @override
  Future<void> resendOtp(String email) async {
    try {
      await dio.post('/api/auth/resend-otp', data: {
        'email': email,
      });
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
