import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'emergency_contact_storage.dart';
import 'package:telephony/telephony.dart';

import 'location_finder.dart';

class SMSSender {
  List<List<String>> emergencyContactList = [];

  static Future<void> sendSMS() async {
    final Telephony telephony = Telephony.instance;
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    Position currentPosition = await LocationModule.determinePosition();
    final latitude = currentPosition.latitude;
    final longitude = currentPosition.longitude;
    String encodedLatitude = Uri.encodeComponent(latitude.toString());
    String encodedLongitude = Uri.encodeComponent(longitude.toString());
    String encodedComma = Uri.encodeComponent(",");
    String mapUrl =
        "https://maps.google.com/maps?q=$encodedLatitude$encodedComma$encodedLongitude";
    if (permissionsGranted!) {
      final dynamic temp =
          jsonDecode(await EmergencyDataStorage.readAllContacts() ?? "[]");

      for (var recipient in temp) {
        debugPrint(mapUrl);
        await telephony.sendSms(
            to: recipient[1],
            message:
                'You have received Emergency Alert from {name}.Here is the location of the alert:\n$mapUrl');
      }
    } else {
      throw Exception("Permission not granted");
    }
  }

  grandPermission() async {
    final Telephony telephony = Telephony.instance;
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    if (permissionsGranted != null || permissionsGranted != false) {
      debugPrint("sms permission denied");
    }
  }
}
