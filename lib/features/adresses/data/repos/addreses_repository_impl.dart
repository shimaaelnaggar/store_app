import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/core/errors/map_exception_to_failure.dart';
import 'package:store/features/adresses/data/data_sources/addresses_remote_datasource.dart';
import 'package:store/features/adresses/data/models/addresses_model.dart';
import 'package:store/features/adresses/domain/entites/addresses.dart';
import 'package:store/features/adresses/domain/repos/addresses_repository_contract.dart';

import '../../../../core/errors/exceptions.dart';

class AddressesRepositoryImpl implements AddressesRepositoryContract {
  final BaseAddressesRemoteDataSource dataSource;

  AddressesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Addresses>> addAddress(
    Addresses address,
  ) async {
    try {
      final response = await dataSource.addAddress(
        AddressesModel(
          id: address.id,
          apartment: address.apartment,
          city: address.city,
          notes: address.notes,
          phoneNumber: address.phoneNumber,
          state: address.state,
          street: address.street,
        ),
      );

      return Right(response.toEntity());
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, List<Addresses>>> getAddresses() async {
    try {
      final response = await dataSource.getAddresses();

      return Right(
        response.map((model) => model.toEntity()).toList(),
      );
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Addresses>> updateAddress(
    Addresses address,
  ) async {
    try {
      final response = await dataSource.updateAddress(
        AddressesModel(
          id: address.id,
          apartment: address.apartment,
          city: address.city,
          notes: address.notes,
          phoneNumber: address.phoneNumber,
          state: address.state,
          street: address.street,
        ),
      );

      return Right(response.toEntity());
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(String id) async {
    try {
      await dataSource.deleteAddress(id);
      return const Right(unit);
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }
}
