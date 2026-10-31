import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/core/errors/map_exception_to_failure.dart';
import 'package:store/features/profile/domain/entites/profile.dart';
import 'package:store/features/profile/domain/repos/profile_repository_contract.dart';

import '../data_sources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepositoryContract {
  final BaseProfileRemoteDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final profile = await dataSource.getProfile();
      return Right(profile);
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }
}
