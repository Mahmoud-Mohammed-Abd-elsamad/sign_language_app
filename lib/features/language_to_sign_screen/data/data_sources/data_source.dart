import 'package:dio/dio.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

import '../../../../core/utils/cach_helper.dart';
import '../../../../core/utils/cosntants.dart';
import '../../domain/entities/language_to_sign_body.dart';
import '../models/sign_to_language_model.dart';

abstract class LanguageToSignDataSource {
  Future<Either<FailureError, LanguageToSignModel>> languageToSignTranslate(
      LanguageToSignBody languageToSignBody);
}

class RemoteLanguageToSignDataSource extends LanguageToSignDataSource {
  @override
  Future<Either<FailureError, LanguageToSignModel>> languageToSignTranslate(
      LanguageToSignBody languageToSignBody) async {
    try {
      var token = CacheHelper.getToken();

      Dio dio = Dio();
      dio.options.headers["authorization"] = "Bearer $token";
      var response = await dio
          .post("${Api.baseUrl}word", data: {"word": languageToSignBody.text});

      if (response.statusCode == 200 || response.statusCode == 201) {
        LanguageToSignModel signToLanguageModel =
            LanguageToSignModel.fromJson(response.data as Map<String, dynamic>);
        return Right(signToLanguageModel);
      } else {
        return Left(RemoteFailure("Failed to translate . try again later"));
      }
    } catch (ex) {
      return left(RemoteFailure("${ex.toString()}======================"));
    }

    ///
  }
}

class LocalLanguageToSignDataSource extends LanguageToSignDataSource {
  @override
  Future<Either<FailureError, LanguageToSignModel>> languageToSignTranslate(
      LanguageToSignBody languageToSignBody) {
    // TODO: implement signToLanguageVideoTranslate
    throw UnimplementedError();
  }
}
