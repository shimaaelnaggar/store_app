import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/auth/domain/entities/login_response.dart';

import '../entities/login.dart';

abstract class LoginRepositoryContract {
  Future<Either<Failure, LoginResponse>> login(Login login);
}
