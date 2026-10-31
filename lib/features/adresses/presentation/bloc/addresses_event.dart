import '../../domain/entites/addresses.dart';

abstract class AddressesEvent {}

class AddAddressesEvent extends AddressesEvent {
  final Addresses address;

  AddAddressesEvent({required this.address});
}

class GetAddressesEvent extends AddressesEvent {}

class UpdateAddressesEvent extends AddressesEvent {}

class DeleteAddressesEvent extends AddressesEvent {}
