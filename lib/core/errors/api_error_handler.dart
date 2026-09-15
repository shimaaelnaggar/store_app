import 'package:dio/dio.dart';
import 'package:store/core/errors/exceptions.dart';

class ApiErrorHandler {
  AppException handle(DioException exception) {
    final getStatusCode = exception.response?.statusCode;
    switch (exception.type) {
      case DioExceptionType.connectionError:
        return NetworkException(
            errorMessage: 'No Internet Connection', statusCode: null);
      case DioExceptionType.badCertificate:
        return CertificateException(
          errorMessage: 'Invalid SSL certificate',
          statusCode: null,
        );
      case DioExceptionType.badResponse:
        return ServerException(
            errorMessage: 'Server returned an error',
            statusCode: getStatusCode);
      case DioExceptionType.cancel:
        return CancelException(
          errorMessage: 'Request was cancelled',
          statusCode: null,
        );
      case DioExceptionType.connectionTimeout:
        return TimeOutException(
          errorMessage: 'Connection timeout',
          statusCode: null,
        );

      case DioExceptionType.receiveTimeout:
        return TimeOutException(
          errorMessage: 'Receive timeout',
          statusCode: null,
        );

      case DioExceptionType.sendTimeout:
        return TimeOutException(
          errorMessage: 'Send timeout',
          statusCode: null,
        );

      case DioExceptionType.transformTimeout:
        return TimeOutException(
          errorMessage: 'Data transformation timeout',
          statusCode: null,
        );
      case DioExceptionType.unknown:
        return UnknownException(
          errorMessage: 'An unexpected error occurred',
          statusCode: getStatusCode,
        );
      default:
        return UnknownException(
          errorMessage: 'An unexpected error occurred',
          statusCode: getStatusCode,
        );
    }
  }
}
