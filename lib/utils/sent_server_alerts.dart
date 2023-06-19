import 'dart:convert';

import 'package:alert_me/utils/location_finder.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ServerAlerts {
  static Future sentAlert() async {
    Position currentPosition = await LocationModule.determinePosition();

    const storage = FlutterSecureStorage();
    final uri = Uri.parse('https://alertme.onrender.com/api/v1/alert');
    final headers = {'Content-Type': 'application/json'};
    final phone = await storage.read(key: "phone");
    final location =
        jsonEncode([currentPosition.latitude, currentPosition.longitude]);
    final time = DateFormat('hh:mm:ss').format(DateTime.now());
    Map<String, dynamic> body = {
      'phone': phone,
      'location': location,
      'time': time
    };
    print(body);
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    if (response.statusCode == 201) {
    } else {}
  }
}
