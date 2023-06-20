import 'dart:async';
import 'package:alert_me/utils/sent_all_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String screen = '';
  static const maxSeconds = 5;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        AlertSendModule.sentAlerts();
        secureStorage.write(key: 'screen', value: 'status');
        setState(() {
          timer?.cancel();

          seconds = maxSeconds;
          screen = 'status';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    secureStorage.read(key: 'screen').then((value) {
      setState(() {
        screen = value ?? 'alert';
      });
      debugPrint("inside init state: $screen");
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("building screen: $screen");
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [returnScreen()],
        ),
      ),
    );
  }

  Widget returnScreen() {
    debugPrint("screen: $screen");

    if (screen == 'alert') {
      return alertButton();
    } else if (screen == 'countdown') {
      return alertCountDown();
    } else if (screen == 'status') {
      return alertStatus();
    } else {
      return const SizedBox();
    }
  }

  Center alertCountDown() {
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
                secureStorage.write(key: 'screen', value: 'alert');
                setState(() {
                  timer?.cancel();
                  seconds = maxSeconds;
                  screen = 'alert';
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

  Widget alertStatus() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.filled(
                onPressed: () {}, icon: Icon(Icons.fire_extinguisher)),
            IconButton.filled(onPressed: () {}, icon: Icon(Icons.warning))
          ],
        ),
        ElevatedButton(
            onPressed: () {
              secureStorage.write(key: 'screen', value: 'alert');
              setState(() {
                screen = 'alert';
              });
            },
            child: const Text("Abort Alert"))
      ],
    );
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
            screen = 'countdown';
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
