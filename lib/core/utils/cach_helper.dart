import 'package:hive/hive.dart';

class CacheHelper {

  static  late dynamic tokenBox ;
  static  late dynamic settingBox ;

  static init() async{
    tokenBox  = await Hive.openBox('tokenBox');
    settingBox = await Hive.openBox('settingBox');
  }


  static saveSettings({required double speechRate , required double volume } ){
    settingBox.putAll({'speechRate': speechRate, "volume": volume});
  }


  static double? getVolumeSettings(){
   return  settingBox.get("volume");
  }

  static double? getSpeechRateSettings(){
    return  settingBox.get("speechRate");
  }

  static saveToken({required String stringToken}) async {

    await tokenBox.put('token', stringToken);
  }

  static String? getToken()  {
    return tokenBox.get('token');
  }

  static deleteToken() {
    tokenBox.delete('token');
  }
}
