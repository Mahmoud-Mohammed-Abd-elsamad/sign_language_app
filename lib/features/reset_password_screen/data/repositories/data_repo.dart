import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/reset_password_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../data_sources/data_source.dart';
import '../models/register_mode.dart';

class ResetPasswordDataRepository extends ResetPasswordDomainRepository{
  ResetPasswordDataRepository(this.resetPasswordDataSource);

  ResetPasswordDataSource resetPasswordDataSource;


  @override
  Future<Either<FailureError, ResetPasswordModel>> resetPassword(ResetPasswordBody resetPasswordBody) {
    return resetPasswordDataSource.resetPassword(resetPasswordBody);
  }
}