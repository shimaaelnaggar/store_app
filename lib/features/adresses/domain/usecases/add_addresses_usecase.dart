import 'package:dartz/dartz.dart';
import 'package:store/features/adresses/domain/repos/addresses_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entites/addresses.dart';

class AddAddressesUseCase {
  final AddressesRepositoryContract repository;

  AddAddressesUseCase({required this.repository});

  Future<Either<Failure, Addresses>> execute(Addresses address) {
    return repository.addAddress(address);
  }
}
