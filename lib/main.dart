//import 'package:AlertMe/pages/Login_RegisterPage.dart';
import 'package:alert_me/utils/find_distance.dart';
import 'package:alert_me/widgets/alert_notification.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AlertMe',
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: LoadingPage(),
        ));
  }
}
