import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlertData {
  String id;
  String name;
  String phone;
  int flagCount;
  int viewCount;
  String time;
  String location;
  int v;

  AlertData(this.id, this.name, this.phone, this.flagCount, this.viewCount,
      this.time, this.location, this.v);
}

class ProfileData {
  String name;
  String phone;
  String time;
  String location;
  String bloodGroup;
  String dateOfBirth;
  String medicalDetails;
  int viewCount;
  int flagCount;

  ProfileData(this.name, this.phone, this.time, this.location, this.bloodGroup,
      this.dateOfBirth, this.medicalDetails, this.viewCount, this.flagCount);
}

class AlertReceiver {
  static Future<List<AlertData>> fetchAllAlert() async {
    final response =
        await http.get(Uri.parse('https://alertme.onrender.com/api/v1/alert'));

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
      debugPrint('$alertDataList');
      return alertDataList;
    } else {
      throw Exception("Failed to fetch alerts");
    }
  }

  static Future<ProfileData> fetchProfileData(String id) async {
    final response = await http
        .get(Uri.parse('https://alertme.onrender.com/api/v1/alert/$id'));

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final profileData = ProfileData(
          responseData['name'],
          responseData['phone'],
          responseData['time'],
          responseData['location'],
          responseData['blood_group'],
          responseData['date_of_birth'],
          responseData['medical_detail'],
          responseData['view_count'],
          responseData['flag_count']);
      return profileData;
    } else {
      throw Exception("Couldn't fetch profile data");
    }
  }
}
