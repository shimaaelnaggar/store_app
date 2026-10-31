import '../../domain/entites/addresses.dart';

abstract class AddressesState {}

class AddressesInitialState extends AddressesState {}

class AddressesLoadingState extends AddressesState {}

class AddressesSuccessState extends AddressesState {
  final List<Addresses> addressesList;
  AddressesSuccessState(this.addressesList);
}

class AddressesFailureState extends AddressesState {
  final String errorMessage;
  AddressesFailureState(this.errorMessage);
}
