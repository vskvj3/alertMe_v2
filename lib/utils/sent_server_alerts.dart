import 'dart:convert';

import 'package:alert_me/utils/location_finder.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ServerAlerts {
  static Future sentAlert() async {
    bool succeess = false;
    while (!succeess) {
      debugPrint("inside the loop");
      try {
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
        debugPrint('$body');
        String jsonBody = json.encode(body);
        final encoding = Encoding.getByName('utf-8');

        Response response = await post(
          uri,
          headers: headers,
          body: jsonBody,
          encoding: encoding,
        );
        Map<String, dynamic> mapresponse = jsonDecode(response.body);
        debugPrint("Erros code: ${response.statusCode}");
        debugPrint("response id: ${mapresponse["_id"]}");
        storage.write(key: 'myalert_id', value: mapresponse["_id"]);
        if (response.statusCode == 201) {
          succeess = true;
          return true;
        } else {
          debugPrint("invalid status code");
          await Future.delayed(const Duration(seconds: 30));
        }
      } catch (e) {
        await Future.delayed(const Duration(seconds: 30));
        debugPrint(e.toString());

        if (e.toString() == 'Connection reset by peer') {
        } else {
          succeess = false;
        }
      }
    }
  }
}
