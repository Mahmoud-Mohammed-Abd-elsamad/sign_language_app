import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/cach_helper.dart';
import '../../../../core/utils/cosntants.dart';
import '../../domain/entities/history_body.dart';
import '../models/sign_to_language_model.dart';

abstract class HistoryDataSource {
  Future<Either<FailureError, HistoryModel>>
  history();
}

class RemoteHistoryDataSource extends HistoryDataSource {
  @override
  Future<Either<FailureError, HistoryModel>>
  history() async {
    try {
      var token =await CacheHelper.getToken();

      Dio dio = new Dio();
      dio.options.headers["authorization"] = "Bearer $token";
      var response = await dio.post("${Api.baseUrl}history");
      if (response.statusCode == 200 || response.statusCode == 201) {
       print("${response.data}***********************************************************");


        HistoryModel historyModel =
        HistoryModel.fromJson(response.data as Map<String, dynamic>);
        return Right(historyModel);
      } else {

        return Left(RemoteFailure("Failed to Load Data"));
      }
    } catch (ex) {
      return left(FailureError("${ex.toString()}======================"));
    }

    ///
  }
}

class LocalHistoryDataSource extends HistoryDataSource {
  @override
  Future<Either<FailureError, HistoryModel>>
  history() {
    // TODO: implement signToLanguageVideoTranslate
    throw UnimplementedError();
  }
}
