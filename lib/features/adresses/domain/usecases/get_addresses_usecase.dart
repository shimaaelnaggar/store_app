import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/addresses.dart';
import '../repos/addresses_repository_contract.dart';

class GetAddressesUseCase {
  final AddressesRepositoryContract repository;

  GetAddressesUseCase({required this.repository});

  Future<Either<Failure, List<Addresses>>> execute() {
    return repository.getAddresses();
  }
}
