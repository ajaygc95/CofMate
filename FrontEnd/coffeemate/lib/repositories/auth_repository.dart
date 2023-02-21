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

  Future<void> persistToken({required String token}) async {
    print(" =============================== ");
    print(" ======= Persist Token ========= ");
    print(" =============================== ");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    final userId = JwtDecoder.decode(token);
    print(userId);
    print(userId['user_id'].runtimeType);
    await prefs.setString('userId', userId['user_id'].toString());

    print(" =============================== ");
    print(" ======= Persist Token  Completed ========= ");
    print(" =============================== ");
  }
}
