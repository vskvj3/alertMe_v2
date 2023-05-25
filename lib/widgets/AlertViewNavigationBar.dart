import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:AlertMe/widgets/alertViewButton.dart';
import 'package:AlertMe/pages/alertsNearPage.dart';
import 'package:AlertMe/homepage.dart';

class AlertViewNavigationBar extends StatelessWidget {
  const AlertViewNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}
