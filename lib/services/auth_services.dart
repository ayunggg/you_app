import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:you_app/models/user_model.dart';
import 'package:you_app/services/session.dart';
import 'package:you_app/services/user_service.dart';

class AuthService {
  final baseUrl = Uri.parse('https://techtest.youapp.ai');

  Future<String> signIn({
    required String email,
    required String username,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/api/login');
    var headers = {'Content-type': 'application/json'};

    var body = jsonEncode({
      'email': email,
      'username': username,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);

      if (data['access_token'] == null) {
        return data['message'];
      } else {
        String token = data['access_token'];

        await SessionManager().addStringToSF(token);
        print("SESSION SVAE");
        print(token);
        print("SETELAH DI SAVE");
        await SessionManager().getStringValuesSF();
        return data['access_token'];
      }
    } else {
      throw ("password must be longer than or equal to 8 characters");
    }
  }

  Future<String> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    var url = Uri.parse("https://techtest.youapp.ai/api/register");
    var headers = {'Content-type': 'application/json'};

    var body = jsonEncode({
      'email': email,
      'username': username,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw ("password must be longer than or equal to 8 characters");
    }
  }
}
