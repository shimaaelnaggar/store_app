import 'package:dartz/dartz.dart';
import 'package:store/features/auth/domain/repos/register_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entities/register.dart';

class CreateAccountUseCase {
  final RegisterRepositoryContract repository;

  CreateAccountUseCase({required this.repository});

  Future<Either<Failure, void>> execute(Register register) {
    return repository.createAccount(register);
  }
}
