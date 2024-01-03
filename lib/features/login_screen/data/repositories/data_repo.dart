import 'package:dartz/dartz.dart';


import '../../../../core/errors/failures.dart';
import '../../../register_screen/data/models/register_mode.dart';
import '../../domain/entities/login_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../data_sources/data_source.dart';

class LoginDataRepo extends LoinDomainRepo {
  LoginDataSource dataSource;

  LoginDataRepo({required this.dataSource});

  @override
  Future<Either<FailureError, RegisterModel>> login(LoginBody body) {
    return dataSource.login(body);
  }
}
