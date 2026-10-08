import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/features/auth/domain/entities/verify_email.dart';
import 'package:store/features/auth/domain/repos/verify_email_repository_contract.dart';

import '../../../../core/errors/map_exception_to_failure.dart';
import '../data_sources/verify_email_remote_datasource.dart';
import '../models/verify_email_model.dart';

class VerifyEmailRepositoryImpl implements VerifyEmailRepositoryContract {
  final BaseVerifyEmailRemoteDateSource dateSource;

  VerifyEmailRepositoryImpl({required this.dateSource});

  @override
  Future<Either<Failure, void>> verifyEmail(VerifyEmail verifyEmail) async {
    try {
      await dateSource.verifyEmail(VerifyEmailModel.fromEntity(verifyEmail));
      return const Right(null);
    } on AppException catch (exception) {
      return Left(mapExceptionToFailure(exception));
    }
  }
}
