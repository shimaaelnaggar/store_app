import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/core/errors/map_exception_to_failure.dart';
import 'package:store/features/auth/data/data_sources/login_remote_datasource.dart';
import 'package:store/features/auth/domain/entities/login.dart';
import 'package:store/features/auth/domain/entities/login_response.dart';
import 'package:store/features/auth/domain/repos/login_repository_contract.dart';

import '../models/login_model.dart';

class LoginRepositoryImpl implements LoginRepositoryContract {
  final BaseLoginRemoteDataSource dataSource;

  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, LoginResponse>> login(Login login) async {
    try {
      final response = await dataSource.login(
        LoginModel.fromEntity(login),
      );
      return Right(response.toEntity());
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }
}
