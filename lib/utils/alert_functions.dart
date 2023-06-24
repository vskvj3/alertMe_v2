import 'package:http/http.dart' as http;

class AlertFunctions {
  static Future<http.Response> updateCount(String id, phone) async {
    return http.put(
      Uri.parse(
          'https://alertme.onrender.com/api/v1/alert/flag/?_id=$id&phone=$phone'),
    );
  }

  static Future<http.Response> updateView(String id, phone) async {
    return http.put(
      Uri.parse(
          'https://alertme.onrender.com/api/v1/alert/view/?_id=$id&phone=$phone'),
    );
  }
}
