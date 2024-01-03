import 'package:dartz/dartz.dart';


import '../../../../core/errors/failures.dart';
import '../../../register_screen/data/models/register_mode.dart';
import '../entities/login_body.dart';

abstract class LoinDomainRepo {
  Future<Either<FailureError, RegisterModel>> login(LoginBody body);
}
