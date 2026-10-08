import 'package:store/features/auth/domain/entities/verify_email.dart';

abstract class VerifyEmailEvent {}

class VerifyEmailRequestedEvent extends VerifyEmailEvent {
  final VerifyEmail verifyEmail;

  VerifyEmailRequestedEvent({
    required this.verifyEmail,
  });
}

class ResendOtpRequestedEvent extends VerifyEmailEvent {
  final String email;

  ResendOtpRequestedEvent({
    required this.email,
  });
}

class StartResendTimerEvent extends VerifyEmailEvent {}

class ResendTimerTickedEvent extends VerifyEmailEvent {}