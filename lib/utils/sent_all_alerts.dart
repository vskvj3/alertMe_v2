import 'dart:convert';
import 'package:alert_me/utils/sent_server_alerts.dart';
import 'package:alert_me/utils/settings_storage.dart';
import 'package:alert_me/utils/alert_sms.dart';

class AlertSendModule {
  static Future<void> sentAlerts() async {
    final List temp =
        jsonDecode(await SettingStorage.retrieveSettings() ?? "[]");
    if (temp.isNotEmpty) {
      if (temp[1] == true) {
        ServerAlerts.sentAlert();
      }
      if (temp[2] == true) {
        SMSSender.sendSMS();
      }
      if (temp[3] == true) {
        //SMSSender.sendhealthSMS();
      }
    }
  }
}
