import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  addStringToSF(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('token');
    print("GET FROM LOCAL");
    print(stringValue);
    return stringValue;
  }

  deleteSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}
