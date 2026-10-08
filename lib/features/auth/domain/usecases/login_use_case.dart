import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/login.dart';
import '../entities/login_response.dart';
import '../repos/login_repository_contract.dart';

class LoginUseCase {
  final LoginRepositoryContract repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, LoginResponse>> execute(Login login) {
    return repository.login(login);
  }
}
