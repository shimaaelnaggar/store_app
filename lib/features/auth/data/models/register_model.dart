import '../../domain/entities/register.dart';

class RegisterModel {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  RegisterModel(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.password});

  factory RegisterModel.fromEntity(Register register) {
    return RegisterModel(
      email: register.email,
      firstName: register.firstName,
      lastName: register.lastName,
      password: register.password,
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
      };
}
