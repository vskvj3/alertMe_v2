
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> _checkboxValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(170, 219, 253, 1),
          title: Text('Settings',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 0),
                child: Text(
                  'Who should get the alert?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),

              SizedBox(height: 30),

              CheckboxListTile(
                  title: Text(
                    'Emergency Contacts',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  value: _checkboxValues[0],
                  onChanged: (value) {
                    setState(() {
                      _checkboxValues[0] = value!;
                    });
                  },
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  tileColor: Color(0xFFF9D1D1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),

              SizedBox(height: 20),
// add color and borderradius
              CheckboxListTile(
                  title: Text(
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
                  tileColor: Color(0xFFF9D1D1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              SizedBox(
                height: 20,
              ),

              CheckboxListTile(
                  title: Text(
                    'Police',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  value: _checkboxValues[2],
                  onChanged: (value) {
                    setState(() {
                      _checkboxValues[2] = value!;
                    });
                  },
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  tileColor: Color(0xFFF9D1D1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: CheckboxListTile(
                  title: Text('Health Care'),
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

              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF9D1D1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: CheckboxListTile(
                  title: Text('All'),
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
        )));
  }
}
