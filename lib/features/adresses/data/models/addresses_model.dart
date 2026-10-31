import 'package:store/features/adresses/domain/entites/addresses.dart';

class AddressesModel {
  final String apartment;
  final String city;
  final String notes;
  final String phoneNumber;
  final String state;
  final String street;
  final String? id;

  AddressesModel(
      {required this.apartment,
      required this.city,
      required this.notes,
      required this.phoneNumber,
      required this.state,
      required this.street,
      this.id});

  factory AddressesModel.fromJson(Map<String, dynamic> json) => AddressesModel(
        id: json["id"],
        apartment: json["apartment"],
        city: json["city"],
        notes: json["notes"],
        phoneNumber: json["phoneNumber"],
        state: json["state"],
        street: json["street"],
      );

  Map<String, dynamic> toJson() => {
        "apartment": apartment,
        "city": city,
        "notes": notes,
        "phoneNumber": phoneNumber,
        "state": state,
        "street": street,
      };

  Addresses toEntity() => Addresses(
        apartment: apartment,
        city: city,
        notes: notes,
        phoneNumber: phoneNumber,
        state: state,
        street: street,
        id: id,
      );
}
