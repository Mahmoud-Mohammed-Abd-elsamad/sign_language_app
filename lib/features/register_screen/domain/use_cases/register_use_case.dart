import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/register_mode.dart';
import '../entities/register_body.dart';
import '../repositories/domain_repo.dart';

class RegisterUseCase{
  RegisterUseCase(this.registerDomainRepository);

  RegisterDomainRepository registerDomainRepository;


 Future<Either<FailureError,RegisterModel>> call(RegisterBody registerBody){
   return registerDomainRepository.register(registerBody);
  }

}
