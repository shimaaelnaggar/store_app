import '../../../domain/entities/register.dart';

class RegisterEvent {}

class CreateAccountEvent extends RegisterEvent {
  final Register register;

  CreateAccountEvent({required this.register});
}
