import 'dart:convert';

import 'package:alert_me/utils/alert_receiver.dart';
import 'package:alert_me/utils/location_finder.dart';
import 'package:alert_me/widgets/alert_list_field.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AlertsNear extends StatefulWidget {
  const AlertsNear({Key? key}) : super(key: key);

  @override
  State<AlertsNear> createState() => _AlertsNearState();
}

class _AlertsNearState extends State<AlertsNear> {
  List<AlertData> alertDataList = [];
  List<AlertData> sortedAlertDataList = [];
  final categories = AlertReceiver.fetchAllAlert();

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

    
    alertDataList = await AlertReceiver.fetchAllAlert();
    sortedAlertDataList= await sortAlertDataList(alertDataList);
    setState(() {
     sortedAlertDataList;
    });

    if (isLocationEnabled) {
      return "Location Enabled";
    } else {
      return "Location Disabled";
    }
  }

  Future<List<AlertData>> sortAlertDataList(List<AlertData> AlertDataList)async{
    final Position currentLocation = await LocationModule.determinePosition();
    for(int i=0;i<alertDataList.length - 1;i++){
      for(int j = 0; j<alertDataList.length-i-1;j++){
        if(await findActualDistance(alertDataList[j].location,currentLocation.latitude,currentLocation.longitude) > await findActualDistance(alertDataList[j+1].location,currentLocation.latitude,currentLocation.longitude)){
          AlertData temp = alertDataList[j+1];
          alertDataList[j+1] = alertDataList[j];
          alertDataList[j] = temp;
        }
      }
    }
    return alertDataList;
  }

  Future<String> findDistance(String remoteLocation) async {
    final Position currentLocation = await LocationModule.determinePosition();
    debugPrint('${currentLocation.latitude}');
    final List<dynamic> locations = json.decode(remoteLocation);
    debugPrint("locations: ${locations[0].toDouble()}");
    debugPrint("locations: ${locations[1]}");
    String distance = LocationModule.calculateDistance(
        locations[0].toDouble(),
        locations[1].toDouble(),
        currentLocation.latitude.toDouble(),
        currentLocation.longitude.toDouble());
    debugPrint('distance: $distance');
    return distance;
  }

  Future<double> findActualDistance(String remoteLocation,lat,long) async {

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
    return FutureBuilder(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: alertDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(index);
                },
              ),
            );
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

  FutureBuilder<String> buildItem(int index) {
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
  }
}
