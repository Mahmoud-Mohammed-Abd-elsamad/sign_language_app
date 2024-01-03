import 'package:hive/hive.dart';

class CacheHelper {
  static saveToken({required String stringToken}) async {
    var box = await Hive.openBox('tokenBox');
    await box.put('token', stringToken);
  }

  static Future<String> getToken() async {
    var box = await Hive.openBox('tokenBox');
    return box.get('token');
  }

  static deleteToken() async {
    var box = await Hive.openBox('tokenBox');
   await box.delete('token');
  }
}
