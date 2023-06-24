import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlertFunctions {
  static Future<http.Response> updateCount(String id, phone) async {
    Uri url = Uri.parse(
        'https://alertme.onrender.com/api/v1/alert/flag/?_id=$id&phone=$phone');
    String encodedUri = Uri.encodeComponent(
        'https://alertme.onrender.com/api/v1/alert/flag/?_id=$id&phone=$phone');
    debugPrint("encoded $encodedUri");
    debugPrint("parsed $url");
    return http.put(url);
  }

  static Future<http.Response> updateView(String id, phone) async {
    return http.put(
      Uri.parse(
          'https://alertme.onrender.com/api/v1/alert/view/?_id=$id&phone=$phone'),
    );
  }
}
