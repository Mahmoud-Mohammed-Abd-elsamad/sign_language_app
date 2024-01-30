
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/register_mode.dart';
import '../entities/reset_password_body.dart';

abstract class ResetPasswordDomainRepository{

  Future<Either<FailureError,ResetPasswordModel>> resetPassword(ResetPasswordBody resetPasswordBody);

}