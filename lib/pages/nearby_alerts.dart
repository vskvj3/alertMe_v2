import 'package:alert_me/widgets/alert_list_field.dart';
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

          AlertListField(
              distance: '500m away', nearFar: 'Near', name: 'Jane Doe'),
          SizedBox(
            height: 10.0,
          ),
          AlertListField(
            distance: '5.2Km away',
            name: 'Mathew alex',
            nearFar: 'Far',
          ),
      
        ],
      ),
    );
  }
}
