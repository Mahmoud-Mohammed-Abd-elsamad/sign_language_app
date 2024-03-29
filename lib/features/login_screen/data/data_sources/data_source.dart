
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


import '../../../../core/errors/failures.dart';
import '../../../../core/utils/cosntants.dart';
import '../../../register_screen/data/models/register_mode.dart';
import '../../domain/entities/login_body.dart';

abstract class LoginDataSource {
  Future<Either<FailureError, RegisterModel>> login(LoginBody body);
}

class LocalLoginDataSource extends LoginDataSource {
  @override
  login(LoginBody body) {
    // TODO: implement login
    throw UnimplementedError();
  }
}

class RemoteLoginDataSource extends LoginDataSource {
  @override
  login(LoginBody body) async {
    try {


    final dio = Dio();
    final response = await dio.post('${Api.baseUrl}login',
    data: {
      "email": body.email,
          "password": body.password,
    },
    );


    // var response = await http.post(
    //   Uri.parse(
    //       'https://cece-156-209-92-61.ngrok-free.app/sign-language/public/api/auth/login'),
    //   body: jsonEncode(<String, String>{
    //     "email": body.email,
    //     "password": body.password,
    //   }),
    // );

      if (response.statusCode == 200 || response.statusCode == 201) {

        RegisterModel registerModel =
            RegisterModel.fromJson(response.data as Map<String, dynamic>);
        return Right(registerModel);
      } else {
        return Left(RemoteFailure("Failed to register"));
      }
    } catch (ex) {
      return left(FailureError("${ex.toString()}=====4================="));
    }

    ///
  }
}
