import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/auth/domain/repos/resend_otp_repository_contract.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/map_exception_to_failure.dart';
import '../data_sources/resend_otp_remote_datasource.dart';

class ResendOtpRepositoryImpl implements ResendOtpRepositoryContract {
  final BaseResendOtpRemoteDataSource remoteDataSource;

  ResendOtpRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, void>> resendOtp(String email) async {
    try {
      await remoteDataSource.resendOtp(email);
      return const Right(null);
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }
}
