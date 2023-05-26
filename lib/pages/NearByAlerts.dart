import 'package:AlertMe/widgets/AlertListField.dart';
import 'package:flutter/material.dart';

class AlertsNear extends StatelessWidget {
  const AlertsNear({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, top: 50, right: 2),
      child: ListView(
        children: const [
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
      ),
    );
  }
}
