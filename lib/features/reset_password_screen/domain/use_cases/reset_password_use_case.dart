import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/register_mode.dart';
import '../entities/reset_password_body.dart';
import '../repositories/domain_repo.dart';

class ResetPasswordUseCase{
  ResetPasswordUseCase(this.resetPasswordDomainRepository);

  ResetPasswordDomainRepository resetPasswordDomainRepository;


 Future<Either<FailureError,ResetPasswordModel>> call(ResetPasswordBody resetPasswordBody){
   return resetPasswordDomainRepository.resetPassword(resetPasswordBody);
  }

}
