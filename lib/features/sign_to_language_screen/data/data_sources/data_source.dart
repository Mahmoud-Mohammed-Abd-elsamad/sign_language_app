
import 'package:dartz/dartz.dart';
import 'package:sign_language_app/core/utils/cosntants.dart';
import 'package:archive/archive_io.dart';

import '../../../../core/errors/failures.dart';
import 'package:http/http.dart' as http;
import 'package:video_compress/video_compress.dart';
import '../../../../core/utils/cach_helper.dart';
import '../../domain/entities/sign_to_language_body.dart';
import '../../presentation/pages/camera_page/camera_page.dart';
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

  print("===================================================${ signToLanguageBody.video} 1");

      // Use an InputFileStream to access the zip file without storing it in memory.
      //final inputStream = InputFileStream(signToLanguageBody.video);

print("=================================================== 2==");


// Decode the zip from the InputFileStream. The archive will have the contents of the
      // zip, without having stored the data in memory.
      // final archive = ZipDecoder().decodeBuffer(inputStream);
      // // For all of the entries in the archive
      // for (var file in archive.files) {
      //   // If it's a file and not a directory
      //   if (file.isFile) {
      //     // Write the file content to a directory called 'out'.
      //     // In practice, you should make sure file.name doesn't include '..' paths
      //     // that would put it outside of the extraction directory.
      //     // An OutputFileStream will write the data to disk.
      //     final outputStream = OutputFileStream('${file.name}');
      //     print("=================================================== 3");
      //
      //     // The writeContent method will decompress the file content directly to disk without
      //     // storing the decompressed data in memory.
      //     file.writeContent(outputStream);
      //     // Make sure to close the output stream so the File is closed.
      //     outputStream.close();
      //   }
      // }



var token = CacheHelper.getToken();
      print("=================================================== 3");

      var request = http.MultipartRequest(
          "POST", Uri.parse('${Api.baseUrl}upload-video'));
      print("=================================================== 4");

      request.headers.addAll({'Authorization': 'Bearer $token',});
print("=================================================== ${mediaInfo!.filesize} 5");
print("=================================================== ${mediaInfo.path} 5");
print("=================================================== ${mediaInfo.path} 5");

request.files.add(await http.MultipartFile.fromPath('video', mediaInfo.path!));
print("=================================================== 6");

      var response =  await request.send();
      // print("${mediaInfo!.file!}=============================================================");

      print("=================================================== 7${response.statusCode}");


      if (response.statusCode == 200 || response.statusCode == 201) {
        print("${response.statusCode}=============================================================");
        SignToLanguageModel signToLanguageModel =
        SignToLanguageModel.fromJson(response.headers);

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
