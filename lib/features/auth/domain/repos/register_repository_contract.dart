import 'package:dartz/dartz.dart';
import 'package:store/features/auth/domain/entities/register.dart';

import '../../../../core/errors/failures.dart';

abstract class RegisterRepositoryContract {
  Future<Either<Failure, void>> createAccount(Register register);
}
