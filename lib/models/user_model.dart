import 'package:equatable/equatable.dart';
import 'package:you_app/models/interest_model.dart';

class UserModel extends Equatable {
  final String? email;
  final String? username;
  final String? password;
  final String? name;
  final String? birthday;
  final String? gender;
  final num? height;
  final num? weight;
  String? imgUrl;
  final String? horoscope;
  final String? zodiac;
  final List<dynamic>? interest;
  String? token;

  UserModel({
    required this.email,
    this.gender,
    required this.username,
    required this.password,
    this.imgUrl,
    this.name = '',
    this.birthday = '',
    this.height = 0,
    this.weight = 0,
    this.interest,
    this.token = '',
    this.horoscope = '',
    this.zodiac = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        password: json['password'],
        username: json['username'],
        name: json['name'],
        birthday: json['birthday'],
        height: json['height'],
        weight: json['weight'],
        interest: json['interests'].map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "username": username,
      "name": name,
      "birthday": birthday,
      "horoscope": horoscope,
      "zodiac": zodiac,
      "height": height,
      "weight": weight,
      "interest": interest!.map((e) => e.toString()).toList(),
      "token": token,
      "gender": gender,
      "imgUrl": imgUrl,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        username,
        password,
        name,
        birthday,
        height,
        weight,
        interest,
        token,
      ];
}
