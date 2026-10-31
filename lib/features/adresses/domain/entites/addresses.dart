import 'package:equatable/equatable.dart';

class Addresses extends Equatable {
  final String apartment;
  final String city;
  final String notes;
  final String phoneNumber;
  final String state;
  final String street;
  final String? id;

  const Addresses(
      {required this.apartment,
      required this.city,
      required this.notes,
      required this.phoneNumber,
      required this.state,
      required this.street,
      this.id});

  @override
  List<Object?> get props => [
        apartment,
        city,
        notes,
        phoneNumber,
        state,
        street,
        id,
      ];
}
