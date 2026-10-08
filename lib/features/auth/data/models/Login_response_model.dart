import 'package:store/features/auth/domain/entities/login_response.dart';

class LoginResponseModel {
  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;

  LoginResponseModel({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'],
      expiresAtUtc: DateTime.parse(json['expiresAtUtc']),
      refreshToken: json['refreshToken'],
    );
  }

  LoginResponse toEntity() => LoginResponse(
      accessToken: accessToken,
      expiresAtUtc: expiresAtUtc,
      refreshToken: refreshToken);
}
