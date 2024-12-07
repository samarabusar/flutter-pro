import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://feeds.ppu.edu/api/v1";
  static String? authToken;

  static Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/login");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        authToken = data['session_token'];
        return true;
      } else {
        print("Login failed: ${response.statusCode}");
        return false;
 }
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }
}