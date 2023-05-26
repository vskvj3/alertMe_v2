import 'dart:async';

import 'package:flutter/material.dart';
import 'package:AlertMe/widgets/AlertViewNavigationBar.dart';
import 'package:AlertMe/widgets/HamburgerMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;
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
          timer?.cancel();
          seconds = maxSeconds;
          isVisible = !isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//AppBar of home page
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: const Text('AlertMe',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            HamburgerMenu(),
          ],
        ),

// body of home page
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isVisible,
              child: alertButton(),
            ),
            Visibility(
              visible: !isVisible,
              child: alertCountDown(),
            ),
          ],
        ),
        bottomNavigationBar: AlertViewNavigationBar(),
      ),
    );
  }

  Center alertCountDown() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 110.0,
          ),
          const Text(
            'Sending Alerts in',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
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
            height: 20.0,
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
  }

  Container alertButton() {
    return Container(
      color: Colors.white,
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
