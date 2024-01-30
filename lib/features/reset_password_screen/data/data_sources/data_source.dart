import 'package:dio/dio.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

import '../../../../core/utils/cosntants.dart';
import '../../domain/entities/reset_password_body.dart';
import '../models/register_mode.dart';

abstract class ResetPasswordDataSource {
  Future<Either<FailureError,ResetPasswordModel>> resetPassword(ResetPasswordBody resetPasswordBody);

}


class RemoteResetPasswordDataSource extends ResetPasswordDataSource {
  @override
  Future<Either<FailureError, ResetPasswordModel>> resetPassword(ResetPasswordBody resetPasswordBody)  async {
    try {
      final dio = Dio();
      final response = await dio.post('${Api.baseUrl}sendEmail',
        data: {
          "name":resetPasswordBody.name ,
          "email": resetPasswordBody.email,
        },
      );


      if (response.statusCode == 200 || response.statusCode == 201) {

        ResetPasswordModel resetPasswordModel =
        ResetPasswordModel.fromJson(response.data);
        return Right(resetPasswordModel);
      } else {

        return Left(FailureError("Failed to reset pass"));
      }
    } catch (ex) {
      return left(FailureError("${ex.toString()}======================"));
    }

    ///
  }

}

class LocalResetPasswordDataSource extends ResetPasswordDataSource {
  @override
  Future<Either<FailureError, ResetPasswordModel>> resetPassword(ResetPasswordBody resetPasswordBody) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}