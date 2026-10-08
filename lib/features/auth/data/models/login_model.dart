import '../../domain/entities/login.dart';

class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  factory LoginModel.fromEntity(Login login) {
    return LoginModel(email: login.email, password: login.password);
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
