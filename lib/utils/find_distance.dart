import 'dart:convert';

import 'package:alert_me/utils/location_finder.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
