import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/profile_model.dart';
import '../repositories/domain_repo.dart';

class ProfileUseCase {
  ProfileUseCase(this.profileDomainRepository);

  ProfileDomainRepository profileDomainRepository;

  Future<Either<FailureError, ProfileModel>> call() {
    return profileDomainRepository
        .profileData();
  }
}
