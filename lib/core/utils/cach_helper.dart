import 'package:hive/hive.dart';

class CacheHelper {

  static  late dynamic box ;

  static init() async{
    box  = await Hive.openBox('tokenBox');
  }


  static saveToken({required String stringToken}) async {
    print("saveToken==============================================================");

    await box.put('token', stringToken);
  }

  static String? getToken()  {
    print("getToken==============================================================");
    return box.get('token');
  }

  static deleteToken() {
    print("deleteToken==============================================================");
    box.delete('token');
  }
}
