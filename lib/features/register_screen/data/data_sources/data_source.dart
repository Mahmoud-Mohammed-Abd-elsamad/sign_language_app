import 'package:dio/dio.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

import '../../../../core/utils/cosntants.dart';
import '../../domain/entities/register_body.dart';
import '../models/register_mode.dart';

abstract class RegisterDataSource {
  Future<Either<FailureError,RegisterModel>> register(RegisterBody registerBody);

}


class RemoteRegisterDataSource extends RegisterDataSource {
  @override
  Future<Either<FailureError, RegisterModel>> register(
      RegisterBody registerBody) async {
    try {
    final dio = Dio();
    final response = await dio.post('${Api.baseUrl}register',
    data: {
          "name":registerBody.name ,
          "email": registerBody.email,
          "password": registerBody.password,
          "password_confirmation": registerBody.password
    },
    );

      // var response = await http.post(
      //   Uri.parse(
      //       'https://cece-156-209-92-61.ngrok-free.app/sign-language/public/api/auth/register'),
      //   body: jsonEncode(<String, String>{
      //     "name":"mostafa adel" ,
      //     "name":"mostafa adel" ,
      //     "email": "mostafa.adel@gmail.com",
      //     "password": "asdfghjk",
      //     "password_confirmation": "asdfghjk"
      //   }),
      // );
      if (response.statusCode == 200 || response.statusCode == 201) {

        RegisterModel registerModel =
            RegisterModel.fromJson(response.data);
        return Right(registerModel);
      } else {

        return Left(FailureError("Failed to register"));
      }
    } catch (ex) {
      return left(FailureError("${ex.toString()}======================"));
    }

    ///
  }
}

class LocalRegisterDataSource extends RegisterDataSource {
  @override
  Future<Either<FailureError, RegisterModel>> register(
      RegisterBody registerBody) {
    // TODO: implement register
    throw UnimplementedError();
  }
}