abstract class AppException {
  final String errorMessage;
  final int? statusCode;

  AppException({required this.errorMessage, required this.statusCode});
}

class ServerException extends AppException {
  ServerException({required String errorMessage, required int? statusCode})
      : super(errorMessage: errorMessage, statusCode: statusCode);
}

class LocalException extends AppException {
  LocalException({required String errorMessage, required int? statusCode})
      : super(errorMessage: errorMessage, statusCode: statusCode);
}

class NetworkException extends AppException {
  NetworkException({required String errorMessage, required int? statusCode})
      : super(errorMessage: errorMessage, statusCode: statusCode);
}

class TimeOutException extends AppException {
  TimeOutException({required String errorMessage, required int? statusCode})
      : super(errorMessage: errorMessage, statusCode: statusCode);
}

class CancelException extends AppException {
  CancelException({
    required String errorMessage,
    required int? statusCode,
  }) : super(
          errorMessage: errorMessage,
          statusCode: statusCode,
        );
}

class CertificateException extends AppException {
  CertificateException({
    required String errorMessage,
    required int? statusCode,
  }) : super(
          errorMessage: errorMessage,
          statusCode: statusCode,
        );
}

class UnknownException extends AppException {
  UnknownException({
    required String errorMessage,
    required int? statusCode,
  }) : super(
          errorMessage: errorMessage,
          statusCode: statusCode,
        );
}