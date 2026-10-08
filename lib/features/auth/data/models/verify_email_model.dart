import '../../domain/entities/verify_email.dart';

class VerifyEmailModel {
  final String email;
  final String otp;

  VerifyEmailModel({required this.email, required this.otp});

  factory VerifyEmailModel.fromEntity(VerifyEmail verifyEmail) {
    return VerifyEmailModel(
      email: verifyEmail.email,
      otp: verifyEmail.otp,
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}
