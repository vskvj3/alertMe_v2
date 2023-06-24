import 'package:alert_me/loadingpage.dart';
import 'package:alert_me/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

logOut(context) async {
  const storage = FlutterSecureStorage();
  await storage.deleteAll();
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoadingPage()),
      (route) => false);
}
