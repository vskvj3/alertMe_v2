import 'dart:convert';

import 'package:alert_me/homepage.dart';
import 'package:alert_me/utils/alert_sms.dart';
import 'package:alert_me/utils/emergency_notif.dart';
import 'package:alert_me/utils/location_finder.dart';
import 'package:alert_me/utils/log_out.dart';
import 'package:alert_me/utils/settings_storage.dart';
import 'package:alert_me/widgets/save_or_add_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Widget button;
  const SettingsPage({super.key, required this.button});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<bool> _checkboxValues = [false, false, false, false];

  // final List<bool> _checkboxValues = [false, false, false, false, false];
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final List temp =
        jsonDecode(await SettingStorage.retrieveSettings() ?? "[]");
    if (temp.isNotEmpty) {
      setState(() {
        _checkboxValues[0] = temp[0];
        _checkboxValues[1] = temp[1];
        _checkboxValues[2] = temp[2];
        _checkboxValues[3] = temp[3];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text('Settings',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              const SizedBox(height: 50.0),

              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10)),
                child: CheckboxListTile(
                  title: const Text('Permanent Notification'),
                  value: _checkboxValues[0],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (value) async {
                    setState(() {
                      _checkboxValues[0] = value!;
                    });
                    await SettingStorage.storeSettings(
                        jsonEncode(_checkboxValues));
                    if (value!) {
                      AppNotif().showNotification(
                          title: "Send Alert", body: "Press to send alert");
                    } else {
                      AppNotif().appNotif.cancel(111);
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 0),
                child: Text(
                  'Who should get the alert?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 30),

              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: CheckboxListTile(
                  title: const Text('Nearby Users'),
                  value: _checkboxValues[1],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (value) async {
                    LocationModule().grandPermission();
                    setState(
                      () {
                        _checkboxValues[1] = value!;
                      },
                    );
                    await SettingStorage.storeSettings(
                        jsonEncode(_checkboxValues));
                  },
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              CheckboxListTile(
                  title: const Text(
                    'Emergency Contacts',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  value: _checkboxValues[2],
                  onChanged: (value) async {
                    SMSSender().grandPermission();
                    setState(
                      () {
                        _checkboxValues[2] = value!;
                      },
                    );
                    await SettingStorage.storeSettings(
                        jsonEncode(_checkboxValues));
                  },
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  tileColor: const Color(0xFFF9D1D1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),

              const SizedBox(
                height: 10,
              ),

// add color and borderradius
              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: CheckboxListTile(
                  title: const Text('Health Care'),
                  value: _checkboxValues[3],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (value) async {
                    setState(
                      () {
                        _checkboxValues[3] = value!;
                      },
                    );
                    await SettingStorage.storeSettings(
                        jsonEncode(_checkboxValues));
                  },
                ),
              ),

              const SizedBox(height: 20),
              ExpansionTile(
                title: const Text("Log Out"),
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await logOut(context);
                      },
                      child: const Text("Log Out"))
                ],
              ),

              CustomButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
