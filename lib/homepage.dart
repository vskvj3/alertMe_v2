import 'dart:async';

import 'package:AlertMe/pages/EmergencyProfilePage.dart';
import 'package:AlertMe/pages/alertsNearPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:AlertMe/widgets/alertViewButton.dart';
import 'package:AlertMe/pages/AboutPage.dart';
import 'package:AlertMe/pages/FAQpage.dart';
import 'package:AlertMe/pages/EmergencyContactsPage.dart';
import 'package:AlertMe/pages/SettingsPage.dart';

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
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              color: const Color.fromRGBO(170, 213, 253, 1),
              onSelected: (String choice) {
                // Handle menu item selection

                if (choice == 'Settings') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                  print('Settings Page');
                } else if (choice == 'Emergency Profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyProfilePage(),
                    ),
                  );
                  print('Emergency Profile Page');
                } else if (choice == 'Emergency Contacts') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyContactsPage(),
                    ),
                  );
                  print('Emergency Contacts Page');
                } else if (choice == 'FAQ') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FAQPage(),
                    ),
                  );
                  print('FAQ Page');
                } else if (choice == 'About') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutPage(),
                    ),
                  );
                  print('About Page');
                } else if (choice == 'Quit') {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  print('Quit');
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                  const PopupMenuDivider(height: 20),
                  const PopupMenuItem<String>(
                    value: 'Emergency Profile',
                    child: Text('Emergency Profile'),
                  ),
                  const PopupMenuDivider(height: 20),
                  const PopupMenuItem<String>(
                    value: 'Emergency Contacts',
                    child: Text('Emergency Contacts'),
                  ),
                  const PopupMenuDivider(height: 20),
                  const PopupMenuItem<String>(
                    value: 'FAQ',
                    child: Text('FAQ'),
                  ),
                  const PopupMenuDivider(height: 20),
                  const PopupMenuItem<String>(
                    value: 'About',
                    child: Text('About'),
                  ),
                  const PopupMenuDivider(height: 20),
                  const PopupMenuItem<String>(
                    value: 'Quit',
                    child: Text('Quit'),
                  ),
                ];
              },
            ),
          ],
        ),

// body of home page

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isVisible,
              child: Container(
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
              ),
            ),
            Visibility(
              visible: !isVisible,
              child: Center(
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
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.red),
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
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(128, 0, 0, 1.0)),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
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
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 75,
            color: Color(0xFFAADBFD),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                alertViewButton('Alert', () {
                  // what happens when the alert button is clicked
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false, // Prevent navigating back
                  );
                }, Colors.red, FontWeight.w400),
                alertViewButton('View', () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlertsNear(),
                    ),
                    (route) => false, // Prevent navigating back
                  );
                  print('Alert View Page');
                }, Colors.black, FontWeight.w400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
