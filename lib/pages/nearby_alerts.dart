import 'package:alert_me/utils/alert_receiver.dart';
import 'package:alert_me/widgets/alert_list_field.dart';
import 'package:flutter/material.dart';
class AlertsNear extends StatefulWidget {
  const AlertsNear({Key? key}) : super(key: key);

  @override
  State<AlertsNear> createState() => _AlertsNearState();
}

class _AlertsNearState extends State<AlertsNear> {
  List<AlertData> alertDataList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    alertDataList = await AlertReceiver.fetchAllAlert();
    setState(() {
      alertDataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: alertDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return AlertListField(
            distance: alertDataList[index].location,
            nearFar: "to be done",
            name: alertDataList[index].name,
            alertDetails: alertDataList[index],
          );
        },
      ),
    );
  }
}
