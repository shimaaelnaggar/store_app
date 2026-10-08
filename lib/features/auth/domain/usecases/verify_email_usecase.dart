import 'package:dartz/dartz.dart';
import 'package:store/features/auth/domain/repos/verify_email_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entities/verify_email.dart';

class VerifyEmailUseCase {
  final VerifyEmailRepositoryContract repository;

  VerifyEmailUseCase({required this.repository});
  Future<Either<Failure, void>> execute(VerifyEmail verifyEmail) {
    return repository.verifyEmail(verifyEmail);
  }
}
