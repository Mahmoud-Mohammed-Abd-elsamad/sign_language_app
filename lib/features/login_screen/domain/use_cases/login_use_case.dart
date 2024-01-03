import 'package:dartz/dartz.dart';


import '../../../../core/errors/failures.dart';
import '../../../register_screen/data/models/register_mode.dart';
import '../entities/login_body.dart';
import '../repositories/domain_repo.dart';

class LoginUseCase {
  LoinDomainRepo domainRepo;

  LoginUseCase({required this.domainRepo});

  Future<Either<FailureError, RegisterModel>> call(LoginBody body) {
    return domainRepo.login(body);
  }
}
