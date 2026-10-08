abstract class VerifyEmailState {}

class VerifyEmailInitialState extends VerifyEmailState {}

class VerifyEmailLoadingState extends VerifyEmailState {}

class VerifyEmailSuccessState extends VerifyEmailState {}

class VerifyEmailErrorState extends VerifyEmailState {
  final String errorMessage;

  VerifyEmailErrorState({
    required this.errorMessage,
  });
}

class ResendOtpLoadingState extends VerifyEmailState {}

class ResendOtpSuccessState extends VerifyEmailState {}

class ResendOtpErrorState extends VerifyEmailState {
  final String errorMessage;

  ResendOtpErrorState({
    required this.errorMessage,
  });
}
