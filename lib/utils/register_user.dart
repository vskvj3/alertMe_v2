import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

registerUser(String? phone, String? loginKey) async {
  try {
    const storage = FlutterSecureStorage();
    final uri = Uri.parse('https://alertme.onrender.com/api/v1/register');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'phone': phone, 'login_key': loginKey};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.reasonPhrase == 'OK') {}
    String responseBody = response.body;

    Map<String, dynamic> mapresponse = jsonDecode(responseBody);
    await storage.write(key: "phone", value: mapresponse["phone"]);
    await storage.write(key: "login_key", value: mapresponse["login_key"]);
    await storage.write(key: "token", value: mapresponse["token"]);

    return mapresponse;
  } catch (err) {
    debugPrint(err.toString());
  }
}
