import 'exceptions.dart';
import 'failures.dart';

Failure mapExceptionToFailure(AppException exception) {
  if (exception is ServerException) {
    return ServerFailure(
      errorMessage: exception.errorMessage,
    );
  }

  if (exception is NetworkException) {
    return NetworkFailure(
      errorMessage: exception.errorMessage,
    );
  }

  if (exception is TimeOutException) {
    return TimeoutFailure(
      errorMessage: exception.errorMessage,
    );
  }

  return UnknownFailure(
    errorMessage: exception.errorMessage,
  );
}
