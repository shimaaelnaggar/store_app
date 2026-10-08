import '../../../domain/entities/login.dart';

class LoginEvent {}

class LoginRequestedEvent extends LoginEvent {
  final Login login;

  LoginRequestedEvent({required this.login});
}
