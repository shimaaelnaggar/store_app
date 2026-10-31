import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';

import '../entites/addresses.dart';

abstract class AddressesRepositoryContract {
  Future<Either<Failure, List<Addresses>>> getAddresses();
  Future<Either<Failure, Addresses>> addAddress(Addresses address);
  Future<Either<Failure, Addresses>> updateAddress(Addresses address);
  Future<Either<Failure, Unit>> deleteAddress(String id);
}
