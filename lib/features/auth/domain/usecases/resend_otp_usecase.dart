import 'package:dartz/dartz.dart';
import 'package:store/features/auth/domain/repos/resend_otp_repository_contract.dart';

import '../../../../core/errors/failures.dart';

class ResendOtpUseCase {
  final ResendOtpRepositoryContract repository;

  ResendOtpUseCase({required this.repository});

  Future<Either<Failure, void>> execute(String email) {
    return repository.resendOtp(email);
  }
}
