import 'package:alert_me/pages/enter_ot_page.dart';
import 'package:flutter/material.dart';
// import 'package:alert_me/homepage.dart';
import 'dart:async';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    startLoadingProcess();
  }

  Future<void> startLoadingProcess() async {
    // Simulate loading process
    await Future.delayed(const Duration(seconds: 3));

    // After loading, navigate to the main app
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginRegister()),
      );
    }
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
