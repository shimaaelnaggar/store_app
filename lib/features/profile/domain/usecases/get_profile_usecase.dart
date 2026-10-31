import 'package:dartz/dartz.dart';
import 'package:store/features/profile/domain/repos/profile_repository_contract.dart';

import '../../../../core/errors/failures.dart';
import '../entites/profile.dart';

class GetProfileUseCase {
  final ProfileRepositoryContract repository;

  GetProfileUseCase({required this.repository});

  Future<Either<Failure, Profile>> execute() {
    return repository.getProfile();
  }
}
