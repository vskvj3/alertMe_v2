import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlertNotif {
  String channelName;
  AlertNotif(this.channelName);

  int cid = (DateTime.now().microsecond.toInt() +
      DateTime.now().millisecond.toInt() +
      DateTime.now().second.toInt());

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
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelName,
        channelName,
        subText: 'Emergency Near You',
        importance: Importance.max,
        icon: 'mipmap/ic_launcher',
        autoCancel: false,
        visibility: NotificationVisibility.public,
      ),
    );
  }

  Future showNotification(
      {int? id = 1, String? title, String? body, String? payload}) async {
    return appNotif.show(cid, title, body, await notificationDetails());
  }
}
