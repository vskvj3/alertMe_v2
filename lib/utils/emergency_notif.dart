import 'package:alert_me/utils/sent_all_alerts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppNotif {
  final appNotif = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await appNotif.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse notificationResponse) async {
      debugPrint("pressed  background notification");
    }, onDidReceiveNotificationResponse:
            (NotificationResponse norificationResponse) async {
      debugPrint("pressed notification");
    });
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('1', 'Notification Button',
          playSound: false,
          enableVibration: false,
          importance: Importance.max,
          icon: 'mipmap/ic_launcher',
          ongoing: true,
          autoCancel: false,
          visibility: NotificationVisibility.public),
    );
  }

  Future showNotification(
      {int id = 111, String? title, String? body, String? payload}) async {
    debugPrint("indise show notification");
    return appNotif.show(id, title, body, await notificationDetails());
  }

    createNotif(){
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  if (!isAllowed) {
    // This is just a basic example. For real apps, you must show some
    // friendly dialog box before call the request method.
    // This is very important to not harm the user experience
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
});
AwesomeNotifications().createNotification(
  content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'Sent Alerts',
      body: '',
      autoDismissible: false,
      criticalAlert: true,  
      locked: true,
      displayOnForeground: true,
      displayOnBackground: true,
  ),
  actionButtons: [
    NotificationActionButton(key: 'alert', label: 'alert',autoDismissible: false,showInCompactView: false)
  ]
);


}
}

class NotificationController{
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();
@pragma("vm:entry-point")
static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  debugPrint("action received!!!");
  final temp = await secureStorage.read(key: 'screen');
  if(temp == 'alert'){
    // Your code goes here
    // Perform your desired action here
    await AlertSendModule.sentAlerts();
    await secureStorage.write(key: "screen", value: "status");
  }
    
}
}
