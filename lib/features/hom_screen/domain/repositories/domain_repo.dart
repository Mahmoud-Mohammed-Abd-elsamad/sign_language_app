import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/profile_model.dart';

abstract class ProfileDomainRepository {
  Future<Either<FailureError, ProfileModel>>
  profileData();
}
