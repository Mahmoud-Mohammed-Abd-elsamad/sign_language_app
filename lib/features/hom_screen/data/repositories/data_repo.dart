import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/domain_repo.dart';
import '../data_sources/data_source.dart';
import '../models/profile_model.dart';

class ProfileDataRepository extends ProfileDomainRepository {
  ProfileDataRepository(this.profileDataSource);

  ProfileDataSource profileDataSource;

  @override
  Future<Either<FailureError, ProfileModel>> profileData() {
    return profileDataSource.profileData();
  }


}
