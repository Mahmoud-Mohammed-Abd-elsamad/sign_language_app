import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/register_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../data_sources/data_source.dart';
import '../models/register_mode.dart';

class RegisterDataRepository extends RegisterDomainRepository{
  RegisterDataRepository(this.registerDataSource);

  RegisterDataSource registerDataSource;


  @override
  Future<Either<FailureError, RegisterModel>> register(RegisterBody registerBody) {
    return registerDataSource.register(registerBody);
  }
}