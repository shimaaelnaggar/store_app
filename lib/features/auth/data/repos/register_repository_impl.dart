import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/auth/domain/entities/register.dart';
import 'package:store/features/auth/domain/repos/register_repository_contract.dart';

import '../../../../core/errors/map_exception_to_failure.dart';
import '../data_sources/register_remote_dataSource.dart';
import '../models/register_model.dart';

class RegisterRepositoryImpl implements RegisterRepositoryContract {
  final BaseRegisterRemoteDataSource dateSource;

  RegisterRepositoryImpl({required this.dateSource});

  @override
  Future<Either<Failure, void>> createAccount(Register register) async {
    try {
      await dateSource.createAccount(RegisterModel.fromEntity(register));
      return const Right(null);
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }
}
