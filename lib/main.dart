//import 'package:AlertMe/pages/Login_RegisterPage.dart';
import 'dart:ui';

import 'package:alert_me/utils/emergency_notif.dart';
import 'package:alert_me/utils/find_distance.dart';
import 'package:alert_me/widgets/alert_notification.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:alert_me/loadingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint("Handling a background message: ${message.messageId}");
  debugPrint('Background Message data: ${message.data}');
  debugPrint('Message data id: ${message.data['id']}');
  String dist = await findDistance(message.data['location']);
  AlertNotif(message.data['name'])
      .showNotification(title: "New Alert", body: dist);
  if (message.notification != null) {
    debugPrint(
        'Message also contained a notification: ${message.notification}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');
    debugPrint(message.data['id']);
    String? dist = await findDistance(message.data['location']);
    AlertNotif(message.data['name'])
        .showNotification(title: "New Alert", body: dist);
    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification}');
    }
  });

 AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  null,
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white)
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupName: 'basic_channel_group',
        channelGroupKey: 'group_key')
  ],
  debug: true
);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initState(){
     AwesomeNotifications().setListeners(
        onActionReceivedMethod:NotificationController.onActionReceivedMethod,
    );

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AlertMe',
        theme: ThemeData(
          dividerColor: Colors.transparent,
          brightness: Brightness.light,
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: LoadingPage(),
        ));
  }
}
