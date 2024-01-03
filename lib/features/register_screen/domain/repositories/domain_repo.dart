
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/register_mode.dart';
import '../entities/register_body.dart';

abstract class RegisterDomainRepository{

  Future<Either<FailureError,RegisterModel>> register(RegisterBody registerBody);

}