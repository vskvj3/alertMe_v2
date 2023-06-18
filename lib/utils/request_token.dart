import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> requestPermissions() async {
  debugPrint("request token is called");
  const storage = FlutterSecureStorage();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // User has granted permission, retrieve the device token
    String? deviceToken = await messaging.getToken();
    print('Device Token: $deviceToken');
    await storage.write(key: "fcmtoken", value: deviceToken);
  } else {
    // User has denied permission
  }
}
