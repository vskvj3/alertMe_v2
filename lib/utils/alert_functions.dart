import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AlertFunctions {
  static Future<http.Response> updateCount(String id) async {
    const storage = FlutterSecureStorage();
    final phone = await storage.read(key: "phone");

    Uri url = Uri.parse(
        'https://alertme.onrender.com/api/v1/alert/flag/?_id=$id&phone=$phone');
    String encodedUri = Uri.encodeComponent(
        'https://alertme.onrender.com/api/v1/alert/flag/?_id=$id&phone=$phone');
    debugPrint("encoded $encodedUri");
    debugPrint("parsed $url");
    return http.put(url);
  }

  static Future<http.Response> updateView(String id) async {
    const storage = FlutterSecureStorage();
    final phone = await storage.read(key: "phone");
    return http.put(
      Uri.parse(
          'https://alertme.onrender.com/api/v1/alert/view/?_id=$id&phone=$phone'),
    );
  }
}
