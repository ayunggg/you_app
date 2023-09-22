import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  addStringToSF(String token, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "token": token,
      "email": email,
      "password": password,
    };

    String encodeMap = jsonEncode(data);

    print(encodeMap);

    await prefs.setString('token', encodeMap);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('token');
    Map<String, dynamic> data = jsonDecode(stringValue!);
    print(data);
    return data;
  }

  deleteSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}
