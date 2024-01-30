import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sign_language_app/core/utils/cosntants.dart';

import '../../../../core/errors/failures.dart';
import 'package:http/http.dart' as http;
import 'package:video_compress/video_compress.dart';
import '../../../../core/utils/cach_helper.dart';
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

      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        signToLanguageBody.video,
        quality: VideoQuality.DefaultQuality,
        deleteOrigin: false, // It's false by default
      );
      var token = CacheHelper.getToken();

      var request = http.MultipartRequest(
          "POST", Uri.parse('${Api.baseUrl}upload-video'));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // mediaInfo!.path!

      request.files
          .add(await http.MultipartFile.fromPath('video', mediaInfo!.path!));
      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {



        SignToLanguageModel signToLanguageModel =
            SignToLanguageModel.fromJson(json.decode( await response.stream.bytesToString()));

        return Right(signToLanguageModel);
      } else {
        return Left(RemoteFailure("else Failed to translate"));
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
