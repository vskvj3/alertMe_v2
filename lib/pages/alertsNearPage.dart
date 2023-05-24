import 'package:AlertMe/widgets/AlertListField.dart';
import 'package:flutter/material.dart';
import 'package:AlertMe/homepage.dart';
import 'package:AlertMe/widgets/alertViewButton.dart';

class AlertsNear extends StatelessWidget {
  Widget verticalDivider = VerticalDivider(thickness: 1, color: Colors.grey);

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(170, 219, 253, 1),
        title: Text('Alerts Recieved',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 2, top: 50, right: 2),
          child: ListView(
            children: [
              //will appear only if an alert is recieved

              alertListField(
                  distance: '500m away', nearFar: 'Near', name: 'Jane Doe'),
              SizedBox(
                height: 10.0,
              ),
              alertListField(
                distance: '5.2Km away',
                name: 'Mathew alex',
                nearFar: 'Far',
              ),
            ],
          )),
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

              // Text(
              //   'Alert',
              //   style: TextStyle(
              //     fontSize: 28.0,
              //     fontWeight: FontWeight.w300,
              //     color: Colors.red,
              //   ),
              // ),
              verticalDivider,
              // Text(
              //   'View',
              //   style: TextStyle(
              //     fontSize: 28.0,
              //     fontWeight: FontWeight.w300,
              //     color: Colors.black,
              //   ),
              // ),
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
    ));
  }
}
