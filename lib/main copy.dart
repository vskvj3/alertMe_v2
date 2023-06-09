// import 'dart:async';
// // import 'package:AlertMe/pages/Login_RegisterPage.dart';
// import 'package:flutter/material.dart';
// import 'package:AlertMe/homepage.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   // Create an instance of FlutterLocalNotificationsPlugin
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize the plugin with app icon
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('./assets/alert.png');

//   // Initialize the settings for each platform
//   final InitializationSettings initializationSettings =
//       InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   // Initialize the plugin with the initialization settings
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   runApp(MyApp());
// }



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//         title: 'AlertMe',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: SafeArea(
//           child: LoadingPage(),
//         ));
//   }
// }

// Future<void> scheduleNotification() async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     'channel_description',
//     importance: Importance.high,
//     priority: Priority.high,
//     playSound: true,
//     enableVibration: true,
//     styleInformation: BigTextStyleInformation(''),

//   );

//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Notification Title',
//     'Notification Body',
//     platformChannelSpecifics,
//     payload: 'notification_payload',
//   );
// }


// class LoadingPage extends StatefulWidget {
//   @override
//   _LoadingPageState createState() => _LoadingPageState();
// }

// class _LoadingPageState extends State<LoadingPage> {
//   @override
//   void initState() {
//     super.initState();
//     startLoadingProcess();
//   }

//   Future<void> startLoadingProcess() async {
//     // Simulate loading process
//     await Future.delayed(Duration(seconds: 3));

//     // After loading, navigate to the main app
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => HomePage()),
//     );
//   }

//   // void startLoadingProcess() {
//   //   Timer(Duration(seconds: 3), () {
//   //     // After loading, navigate to the main app
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => HomePage()),
//   //     );
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Center(
//         child: Container(
//           padding: EdgeInsets.only(bottom: 100),
//           height: 295,
//           child: Column(children: [
//             Image.asset(
//               'assets/alert.png',
//               height: 130,
//               width: 130,
//             ),

//             SizedBox(
//               height: 30,
//             ),
//             SizedBox(),

//             Text(
//               'AlertMe',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             // CircularProgressIndicator()
//           ]),
//         ),
//       ),
//     ));
//   }
// }
