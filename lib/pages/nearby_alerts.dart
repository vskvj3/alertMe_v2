import 'dart:convert';

import 'package:alert_me/utils/alert_receiver.dart';
import 'package:alert_me/utils/location_finder.dart';
import 'package:alert_me/utils/time_difference.dart';
import 'package:alert_me/widgets/alert_list_field.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class AlertsNear extends StatefulWidget {
  const AlertsNear({Key? key}) : super(key: key);

  @override
  State<AlertsNear> createState() => _AlertsNearState();
}

class _AlertsNearState extends State<AlertsNear> {
  late Position currentLocation;
  

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<String> init() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Location is Disabled"),
              content:
                  const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    const AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
    currentLocation = await LocationModule.determinePosition();
    debugPrint('${currentLocation.latitude}');
    debugPrint('${currentLocation.longitude}');
    
    setState(() {
      currentLocation;
    });

    if (isLocationEnabled) {
      return "Location Enabled";
    } else {
      return "Location Disabled";
    }
  }

  Future<List<AlertData>> sortAlertDataList(
      List<AlertData> AlertDataList) async {
    final Position currentLocation = await LocationModule.determinePosition();
    for (int i = 0; i < AlertDataList.length - 1; i++) {
      for (int j = 0; j < AlertDataList.length - i - 1; j++) {
        if (await findActualDistance(AlertDataList[j].location,
                currentLocation.latitude, currentLocation.longitude) >
            await findActualDistance(AlertDataList[j + 1].location,
                currentLocation.latitude, currentLocation.longitude)) {
          AlertData temp = AlertDataList[j + 1];
          AlertDataList[j + 1] = AlertDataList[j];
          AlertDataList[j] = temp;
        }
      }
    }
    return AlertDataList;
  }

  Future<List<AlertData>> fetchAndSortAlertDataList() async {
   List<AlertData> alertDataList = await AlertReceiver.fetchAllAlert();
  List<AlertData> sortedAlertDataList = await sortAlertDataList(alertDataList);
    return sortedAlertDataList;
  }

  Future<String> findDistance(String remoteLocation,lat,lon) async {
    
    final List<dynamic> locations = json.decode(remoteLocation);
    debugPrint("locations: ${locations[0].toDouble()}");
    debugPrint("locations: ${locations[1]}");
    String distance = LocationModule.calculateDistance(
        locations[0].toDouble(),
        locations[1].toDouble(),
        lat.toDouble(),
        lon.toDouble());
    debugPrint('distance: $distance');
    return distance;
  }

  Future<double> findActualDistance(String remoteLocation, lat, long) async {
    final List<dynamic> locations = json.decode(remoteLocation);
    debugPrint("locations: ${locations[0].toDouble()}");
    debugPrint("locations: ${locations[1]}");
    double distance = LocationModule.calculateActualDistance(
        locations[0].toDouble(),
        locations[1].toDouble(),
        lat.toDouble(),
        long.toDouble());
    debugPrint('distance: $distance');
    return distance;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlertData>>(
      future:fetchAndSortAlertDataList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            debugPrint("alertDatalist lengt: ${snapshot.data!.length}");
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Alerts Found'));
            } else {
              return SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:  snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildItem(snapshot.data![index]);
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/icons/net_error.png'),
                  semanticLabel: "",
                  height: 50,
                  width: 50,
                ),
                Text(snapshot.error.toString()),
              ],
            ));
          } else {
            return const Center(child: Text('No Alerts Found'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  FutureBuilder<String> buildItem(AlertData alertData) {
    String currentTimeString = DateFormat('hh:mm:ss').format(DateTime.now());
    return FutureBuilder(
      future: findDistance(alertData.location,currentLocation.latitude,currentLocation.longitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final distance = snapshot.data as String;
          if (alertData.status == "aborted") {
            return Stack(children: [
              AlertListField(
                distance: "-----",
                nearFar: "-----",
                name: "-----",
                alertDetails: alertData,
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          "Alert Resolved",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  )),
            ]);
          }
          return AlertListField(
            distance: distance,
            // nearFar: "flagged: ${alertDataList[index].flagCount}",
            nearFar:
                timeDifference(currentTimeString, alertData.time),
            name: alertData.name,
            alertDetails: alertData,
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
  }
}
