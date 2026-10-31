import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_addresses_usecase.dart';
import '../../domain/usecases/get_addresses_usecase.dart';
import 'addresses_event.dart';
import 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final GetAddressesUseCase getAddressesUseCase;
  final AddAddressesUseCase addAddressesUseCase;

  AddressesBloc(
      {required this.getAddressesUseCase, required this.addAddressesUseCase})
      : super(AddressesInitialState()) {
    on<AddAddressesEvent>((event, emit) async {
      emit(AddressesLoadingState());
      final result = await addAddressesUseCase.execute(event.address);
      result.fold(
        (failure) => emit(AddressesFailureState(failure.errorMessage)),
        (address) => emit(AddressesSuccessState([address])),
      );
    });
    on<GetAddressesEvent>((event, emit) async {
      emit(AddressesLoadingState());
      final result = await getAddressesUseCase.execute();
      result.fold(
        (failure) => emit(AddressesFailureState(failure.errorMessage)),
            (addresses) {
          debugPrint('Addresses count: ${addresses.length}');

          for (final address in addresses) {
            debugPrint(
              'Address: ${address.state}, ${address.city}, '
                  '${address.street}, id: ${address.id}',
            );
          }

          emit(AddressesSuccessState(addresses));
        },
      );
    });
  }
}
