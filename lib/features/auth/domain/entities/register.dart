import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  const Register({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });
  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        password,
      ];
}
