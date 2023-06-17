import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlertData {
  String id;
  String? name;
  String? phone;
  String? flagCount;
  String? viewCount;
  String? time;
  String? location;
  int v;

  AlertData(this.id, this.name, this.phone, this.flagCount, this.viewCount,
      this.time, this.location, this.v);
}

class AlertReceiver {
  static Future<List<AlertData>> fetchAlert() async {
    final response =
        await http.get(Uri.parse('https://alertme.onrender.com/api/v1/alert'));

        debugPrint(response.body);
    if (response.statusCode == 201) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<AlertData> alertDataList = responseData.map((json) {

        return AlertData(
          json['_id'],
          json['name'],
          json['phone'],
          json['flag_count'],
          json['view_count'],
          json['time'],
          json['location'],
          json['__v'],
        );
      }).toList();
      return alertDataList;
    } else {
      throw Exception("Failed to fetch alerts");
    }
  }
}
