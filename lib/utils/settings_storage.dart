

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingStorage{
  static const settingStorage = FlutterSecureStorage();
  static const skey = "SKey";
  static Future<String?> retrieveSettings() async =>
    await settingStorage.read(key:skey);
  static Future<void> storeSettings(String temp) async {
    await settingStorage.write(key: skey,value:temp);
  }
      
}
