import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotif {
  final appNotif = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await appNotif.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('1', 'Notification Button',
          playSound: false,
          enableVibration: false,
          showWhen: false,
          importance: Importance.max,
          icon: 'mipmap/ic_launcher',
          ongoing: true,
          autoCancel: false,
          visibility: NotificationVisibility.public),
    );
  }

  Future showNotification(
      {int id = 111, String? title, String? body, String? payload}) async {
    return appNotif.show(id, title, body, await notificationDetails());
  }
}
