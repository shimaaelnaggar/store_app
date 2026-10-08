import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class ResendOtpRepositoryContract {
  Future<Either<Failure, void>> resendOtp(String email);
}
