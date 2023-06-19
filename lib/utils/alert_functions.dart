
import 'package:http/http.dart' as http;


class AlertFunctions{
  static Future<http.Response> updateCount(String id) async {
  return http.put(
    Uri.parse('https://alertme.onrender.com/api/v1/alert/flag/$id'),
  );
}
}