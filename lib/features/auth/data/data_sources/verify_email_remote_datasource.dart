import 'package:dio/dio.dart';
import 'package:store/features/auth/data/models/verify_email_model.dart';

import '../../../../core/errors/api_error_handler.dart';

abstract class BaseVerifyEmailRemoteDateSource {
  Future<void> verifyEmail(VerifyEmailModel verifyEmailModel);
}

class VerifyEmailRemoteDataSource implements BaseVerifyEmailRemoteDateSource {
  final Dio dio;

  VerifyEmailRemoteDataSource({required this.dio});

  @override
  Future<void> verifyEmail(VerifyEmailModel verifyEmailModel) async {
    try {
      dio.post(
        '/api/auth/verify-email',
        data: verifyEmailModel.toJson(),
      );
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
