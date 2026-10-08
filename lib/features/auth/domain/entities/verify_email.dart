import 'package:equatable/equatable.dart';

class VerifyEmail extends Equatable {
  final String email;
  final String otp;

  const VerifyEmail({required this.email, required this.otp});
  @override
  List<Object?> get props => [email, otp];
}
