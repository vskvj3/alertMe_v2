import 'dart:async';
// import 'package:alert_me/utils/alert_sms.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  bool isVisible = true;
  bool isMenuVisible = false;
  static const maxSeconds = 5;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        setState(() {
          // SMSSender.sendSMS();
          timer?.cancel();

          seconds = maxSeconds;
          // isVisible = !isVisible;
          isMenuVisible = !isMenuVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isVisible == false
              ? [
                  alertCountDown(),
                ]
              : [
                  alertButton(),
                ],
        ),
      ),
    );
  }

  Center alertCountDown() {
    if (isMenuVisible == false) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sending Alerts in',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: (seconds / maxSeconds),
                    valueColor: const AlwaysStoppedAnimation(Colors.red),
                    strokeWidth: 12,
                  ),
                  Center(
                      child: Text(
                    '$seconds',
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(128, 0, 0, 1.0)),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    timer?.cancel();
                    seconds = maxSeconds;
                    isVisible = !isVisible;
                  });
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isMenuVisible = !isMenuVisible;
                    isVisible = !isVisible;
                  });
                },
                child: Text("Abort Alert"))
          ],
        ),
      );
    }
  }

  Container alertButton() {
    return Container(
      height: 293.0,
      padding: const EdgeInsets.only(),
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          startTimer();

          setState(() {
            isVisible = !isVisible;
          });

          // Handle panic button press event
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<CircleBorder>(
            const CircleBorder(),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(120),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.red,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.red[800]!,
          ),
          elevation: MaterialStateProperty.all<double>(10.0),
          shadowColor: MaterialStateProperty.all<Color>(
            Colors.red[800]!,
          ),
          animationDuration: const Duration(milliseconds: 200),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        child: const Text(
          'ALERT',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
