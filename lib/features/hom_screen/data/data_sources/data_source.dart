
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/cach_helper.dart';
import '../../../../core/utils/cosntants.dart';
import '../models/profile_model.dart';

abstract class ProfileDataSource {
  Future<Either<FailureError, ProfileModel>>
  profileData();
}

class RemoteProfileDataSource extends ProfileDataSource {
  @override
  Future<Either<FailureError, ProfileModel>>
  profileData() async {
    try {
      var token = CacheHelper.getToken();

      Dio dio =  Dio();
      dio.options.headers["authorization"] = "Bearer $token";
      var response = await dio.post("${Api.baseUrl}me");
      if (response.statusCode == 200 || response.statusCode == 201) {


       ProfileModel profileModel =
       ProfileModel.fromJson(response.data as Map<String, dynamic>);
        return Right(profileModel);
      } else {

        return Left(RemoteFailure("Failed to Load Data"));
      }
    } catch (ex) {
      return left(FailureError("${ex.toString()}======================"));
    }

    ///
  }
}

class LocalProfileDataSource extends ProfileDataSource {
  @override
  Future<Either<FailureError, ProfileModel>>
  profileData() {
    // TODO: implement signToLanguageVideoTranslate
    throw UnimplementedError();
  }
}
