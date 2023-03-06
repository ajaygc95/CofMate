import 'dart:convert';
import 'package:coffeemate/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepository {
  Future<String> authenticate(
      {required String username, required String password}) async {
    final response = await http.post(
      Uri.parse(loginApi),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access'];
      print(" =============== Token Received ================= $token");
      return token;
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<bool> checkProfileExistence({required String token}) async {
    print(" =============================== ");
    print(" ======= Checking If profile Exists ========= ");

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    print(" ++++++ This is user ID +++++++++++++ ");
    print(" ======= $userId ${userId.runtimeType}========= ");
    if (userId == null) {
      throw Exception('User ID not found in shared preferences');
    }
    final url = Uri.parse('$profileApi$userId/');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(" =============================== ");
      print(" ======= Profile Exists ========= ");

      final jsonData = json.decode(response.body);
      print(" =========== ${jsonData['user']} ============ ");
      print(" =========== ${response.body} ============ ");
      return true;
    }
    print(" =============================== ");
    print(" ======= Profile Doesn't Exist ========= ");
    return false; // The profile does not exist
  }

  Future<String> getProfile(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      throw Exception('User ID not found in shared preferences');
    }
    final url = Uri.parse('$profileApi$userId/');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return response.body;
    }

    return ''; // Return empty string if the profile does not exist
  }

  Future<void> persistToken({required String token}) async {
    print(" =============================== ");
    print(" ======= Persist Token ========= ");
    print(" =============================== ");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    final userId = JwtDecoder.decode(token);
    print(userId['user_id'].runtimeType);
    await prefs.setString('userId', userId['user_id'].toString());

    print(" =============================== ");
    print(" ======= Persist Token  Completed ========= ");
    print(" =============================== ");
  }
}
