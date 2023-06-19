import 'dart:convert';

import 'package:alert_me/utils/alert_receiver.dart';
import 'package:alert_me/utils/location_finder.dart';
import 'package:alert_me/widgets/alert_list_field.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AlertsNear extends StatefulWidget {
  const AlertsNear({Key? key}) : super(key: key);

  @override
  State<AlertsNear> createState() => _AlertsNearState();
}

class _AlertsNearState extends State<AlertsNear> {
  List<AlertData> alertDataList = [];
  final categories = AlertReceiver.fetchAllAlert();

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

  Future<String> findDistance(String remoteLocation) async {
    final Position currentLocation = await LocationModule.determinePosition();
    debugPrint('${currentLocation.latitude}');
    final List<dynamic> locations = json.decode(remoteLocation);
    print("locations: ${locations[0].toDouble()}");
    print("locations: ${locations[1]}");
    String distance = LocationModule.calculateDistance(
        locations[0].toDouble(),
        locations[1].toDouble(),
        currentLocation.latitude.toDouble(),
        currentLocation.longitude.toDouble());
    debugPrint('distance: $distance');
    // Calculate the distance using the current location and the remote location
    // Replace the return statement with your distance calculation logic
    return distance;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: alertDataList.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: findDistance(alertDataList[index].location),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final distance = snapshot.data as String;
                      return AlertListField(
                        distance: distance,
                        nearFar: "flagged: ${alertDataList[index].flagCount}",
                        name: alertDataList[index].name,
                        alertDetails: alertDataList[index],
                      );
                    } else {
                      return const Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    }
                  },
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
