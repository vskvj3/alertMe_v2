
//import 'package:AlertMe/pages/Login_RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:alert_me/loadingpage.dart';




void main() => runApp(const MyApp());

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
