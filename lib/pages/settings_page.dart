import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<bool> _checkboxValues = [false, false, false, false, false];

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
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 0),
                child: Text(
                  'Who should get the alert?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 30),

              CheckboxListTile(
                  title: const Text(
                    'Emergency Contacts',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  value: _checkboxValues[0],
                  onChanged: (value) {
                    setState(
                      () {
                        _checkboxValues[0] = value!;
                      },
                    );
                  },
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  tileColor: const Color(0xFFF9D1D1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),

              const SizedBox(height: 20),
// add color and borderradius
              CheckboxListTile(
                  title: const Text(
                    'Nearby Users',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  value: _checkboxValues[1],
                  onChanged: (value) {
                    setState(() {
                      _checkboxValues[1] = value!;
                    });
                  },
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  tileColor: const Color(0xFFF9D1D1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(
                height: 20,
              ),

              CheckboxListTile(
                  title: const Text(
                    'Police',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  value: _checkboxValues[2],
                  onChanged: (value) {
                    setState(
                      () {
                        _checkboxValues[2] = value!;
                      },
                    );
                  },
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  tileColor: const Color(0xFFF9D1D1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
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
                  onChanged: (value) {
                    setState(
                      () {
                        _checkboxValues[3] = value!;
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: CheckboxListTile(
                  title: const Text('All'),
                  value: _checkboxValues[4],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(
                      () {
                        _checkboxValues[4] = value!;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
