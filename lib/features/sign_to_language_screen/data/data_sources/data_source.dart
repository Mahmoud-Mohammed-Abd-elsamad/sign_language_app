import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/sign_to_language_body.dart';
import '../models/sign_to_language_model.dart';

abstract class SignToLanguageDataSource {
  Future<Either<FailureError, SignToLanguageModel>>
      signToLanguageVideoTranslate(SignToLanguageBody signToLanguageBody);
}

class RemoteSignToLanguageDataSource extends SignToLanguageDataSource {
  @override
  Future<Either<FailureError, SignToLanguageModel>>
      signToLanguageVideoTranslate(
          SignToLanguageBody signToLanguageBody) async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/sign-language/public/api/auth/register'),
        body: jsonEncode(<String, String>{
          "name": signToLanguageBody.name,
          "email": signToLanguageBody.email,
          "password": signToLanguageBody.password,
          "password_confirmation": signToLanguageBody.rePassword
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            signToLanguageBody.email + " email =============================");
        print(signToLanguageBody.name + " name =============================");

        SignToLanguageModel signToLanguageModel =
            SignToLanguageModel.fromJson(response.body as Map<String, dynamic>);
        return Right(signToLanguageModel);
      } else {
        print(
            signToLanguageBody.email + " email =============================");
        print(signToLanguageBody.name + " name =============================");

        return Left(RemoteFailure("Failed to register"));
      }
    } catch (ex) {
      return left(RemoteFailure("${ex.toString()}======================"));
    }

    ///
  }
}

class LocalSignToLanguageDataSource extends SignToLanguageDataSource {
  @override
  Future<Either<FailureError, SignToLanguageModel>>
      signToLanguageVideoTranslate(SignToLanguageBody signToLanguageBody) {
    // TODO: implement signToLanguageVideoTranslate
    throw UnimplementedError();
  }
}
