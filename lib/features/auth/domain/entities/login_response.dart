import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;

  const LoginResponse(
      {required this.accessToken,
      required this.expiresAtUtc,
      required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, expiresAtUtc, refreshToken];
}
