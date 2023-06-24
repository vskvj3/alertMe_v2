import 'dart:async';
import 'package:alert_me/utils/sent_all_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

String _value = "";

class _AlertPageState extends State<AlertPage> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
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

  updateAlertTag(tag) async {
    var id = await secureStorage.read(key: 'myalert_id');
    debugPrint("alerttag for $id changing to $tag");
    final uri = Uri.parse(
        'https://alertme.onrender.com/api/v1/alert/updatetag/?_id=$id&tag=$tag');
    http.put(uri);
  }

  abortAlert() async {
    var id = await secureStorage.read(key: 'myalert_id');
    final uri =
        Uri.parse('https://alertme.onrender.com/api/v1/alert/abort/$id');
    http.put(uri);
  }

  Widget alertStatus() {
    return Column(
      children: [
        Wrap(
          spacing: 20,
          children: [
            ChoiceChip(
              label: const Image(
                image: AssetImage('assets/icons/flame.png'),
                semanticLabel: "",
                height: 60,
                width: 60,
              ),
              selected: _value == "flame",
              onSelected: (selected) {
                debugPrint("seleted: $selected");
                setState(() {
                  _value = "flame";
                });
                updateAlertTag(_value);
              },
            ),
            ChoiceChip(
              label: const Image(
                image: AssetImage('assets/icons/accident.png'),
                semanticLabel: "",
                height: 60,
                width: 60,
              ),
              selected: _value == "accident",
              onSelected: (selected) {
                debugPrint("seleted: $selected");
                setState(() {
                  _value = "accident";
                });
                updateAlertTag(_value);
              },
            ),
            ChoiceChip(
              label: const Image(
                image: AssetImage('assets/icons/heart-attack2.png'),
                semanticLabel: "",
                height: 60,
                width: 60,
              ),
              selected: _value == "heartattack",
              onSelected: (selected) {
                debugPrint("seleted: $selected");
                setState(() {
                  _value = "heartattack";
                });
                updateAlertTag(_value);
              },
            )
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 70),
              backgroundColor: Colors.red, // Set the button color
            ),
            onPressed: () {
              try {
                abortAlert();
              } catch (err) {
                debugPrint(err.toString());
              }
              secureStorage.write(key: 'screen', value: 'alert');
              setState(() {
                screen = 'alert';
                _value = "";
              });
            },
            child: const Text(
              "Abort Alert",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))
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
