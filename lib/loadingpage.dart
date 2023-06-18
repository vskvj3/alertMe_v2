import 'package:alert_me/homepage.dart';
import 'package:alert_me/pages/register_page.dart';
import 'package:alert_me/utils/request_token.dart';
import 'package:flutter/material.dart';
// import 'package:alert_me/homepage.dart';
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  checkLoggedIn() async {}

  @override
  void initState() {
    super.initState();
    // requestPermissions();
    startLoadingProcess();
  }

  Future<void> startLoadingProcess() async {
    // Simulate loading process
    await Future.delayed(const Duration(seconds: 1));

    requestPermissions();
    final storage = FlutterSecureStorage();
    var loggedin = await storage.read(key: 'loggedin');
    debugPrint("loggedin: $loggedin");
    if (loggedin == null) {
      debugPrint("Not logged in ");
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginRegister()),
        );
      }
    } else if (loggedin == 'true') {
      debugPrint("user logged in");
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }

    // After loading, navigate to the main app
  }

  // void startLoadingProcess() {
  //   Timer(Duration(seconds: 3), () {
  //     // After loading, navigate to the main app
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/alert.png',
                height: 130,
                width: 130,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'AlertMe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
