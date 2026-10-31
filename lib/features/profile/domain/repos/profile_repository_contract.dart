import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';

import '../entites/profile.dart';

abstract class ProfileRepositoryContract {
  Future<Either<Failure, Profile>> getProfile();
}
