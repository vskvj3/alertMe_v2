// ignore: depend_on_referenced_packages


import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class EmergencyDataStorage{
  
  static const emergencyContactstorage = FlutterSecureStorage();
  static String  contactKey = "ContactKey";
  
  static Future<String?> readAllContacts() async => 
      await emergencyContactstorage.read(key:contactKey);
  static Future<void> storeContacts(String temp) async => 
      await emergencyContactstorage.write(key:contactKey,value:temp);

    static Future<void> deleteAll() async{
      await emergencyContactstorage.deleteAll();
    }

}

