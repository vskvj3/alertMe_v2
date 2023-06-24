import 'dart:convert';
// import 'package:alert_me/utils/request_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

registerUser(String? phone, String? loginKey) async {
  try {
    const storage = FlutterSecureStorage();
    final fcmtoken = await storage.read(key: 'fcmtoken');
    final uri = Uri.parse('https://alertme.onrender.com/api/v1/register');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'phone': phone,
      'login_key': loginKey,
      'fcmtoken': fcmtoken
    };
    debugPrint("body in registerUser: $body");
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
    debugPrint("mapresponse in registerUser: $mapresponse");
    await storage.write(key: "phone", value: mapresponse["phone"]);
    await storage.write(key: "login_key", value: mapresponse["login_key"]);
    await storage.write(key: "token", value: mapresponse["token"]);
    await storage.write(key: "loggedin", value: 'true');

    return mapresponse;
  } catch (err) {
    debugPrint(err.toString());
  }
}
