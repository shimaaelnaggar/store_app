abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
        );
}

class NetworkFailure extends Failure {
  NetworkFailure({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
        );
}

class TimeoutFailure extends Failure {
  TimeoutFailure({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
        );
}

class UnknownFailure extends Failure {
  UnknownFailure({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
        );
}
