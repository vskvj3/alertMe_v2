
import 'dart:async';
import 'package:abin_second_app/pages/Login_RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:abin_second_app/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    startLoadingProcess();
  }

  Future<void> startLoadingProcess() async {
    // Simulate loading process
    await Future.delayed(Duration(seconds: 3));

    // After loading, navigate to the main app
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 100),
          height: 295,
          child: Column(children: [
            Image.asset(
              'assets/alert.png',
              height: 130,
              width: 130,
            ),

            SizedBox(
              height: 30,
            ),
            SizedBox(),

            Text(
              'AlertMe',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            // CircularProgressIndicator()
          ]),
        ),
      ),
    );
  }
}
