import 'dart:convert';
import 'emergency_contact_storage.dart';
import 'package:telephony/telephony.dart';

class SMSSender {

    List<List<String>> emergencyContactList = [];


    static Future<void> sendSMS() async {
    final Telephony telephony = Telephony.instance;
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    print(permissionsGranted);

    final dynamic temp =
        jsonDecode(await EmergencyDataStorage.readAllContacts() ?? "[]");

    for(var recipient in temp){
    await telephony.sendSms(to: recipient[1], message: 'Hello, this is a test message.');
    print("SMS Sent");
    }
  }

}

