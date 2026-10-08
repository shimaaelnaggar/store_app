import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/auth/domain/entities/verify_email.dart';

abstract class VerifyEmailRepositoryContract {
  Future<Either<Failure, void>> verifyEmail(VerifyEmail verifyEmail);
}
