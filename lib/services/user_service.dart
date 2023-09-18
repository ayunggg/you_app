import 'dart:convert';

import 'package:you_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:you_app/services/session.dart';

class UserService {
  final baseUrl = Uri.parse('https://techtest.youapp.ai');

  Future<UserModel> getProfile(String token) async {
    var url = Uri.parse('$baseUrl/api/getProfile');
    var headers = {'x-access-token': token};

    var response = await http.get(
      url,
      headers: headers,
    );

    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(res['data']);
      user.token = token;
      return user;
    } else {
      throw ("Something went wrong");
    }
  }

  Future<UserModel> updateProfile(
    String token,
    String name,
    String birthday,
    num weight,
    num height,
    List<dynamic> list,
    String horoscope,
    String zodiac,
    String gender,
    String imgUrl,
  ) async {
    var url = Uri.parse('$baseUrl/api/updateProfile');
    var headers = {'x-access-token': token, 'Content-type': 'application/json'};

    var body = jsonEncode({
      'name': name,
      'birthday': birthday,
      'weight': weight,
      'height': height,
    });

    var response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    print("RESPONNYA");
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      UserModel user = UserModel.fromJson(data['data']);
      user.imgUrl = imgUrl;
      return user;
    } else {
      var data = jsonDecode(response.body);

      return data['message'];
    }
  }

  Future<UserModel> updateInterest(String token, UserModel userModel) async {
    var url = Uri.parse('$baseUrl/api/updateProfile');
    var headers = {'x-access-token': token, 'Content-type': 'application/json'};

    var body = jsonEncode({
      'name': userModel.username,
      'birthday': userModel.birthday,
      'weight': userModel.weight,
      'height': userModel.height,
      "interests": userModel.interest
    });

    var response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      UserModel user = UserModel.fromJson(data['data']);

      return user;
    } else {
      var data = jsonDecode(response.body);

      return data['message'];
    }
  }
}
