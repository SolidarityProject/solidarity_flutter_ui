import 'dart:convert';

import 'package:solidarity_flutter_ui/models/address_model.dart';

class User {
  String id;
  String name;
  String lastname;
  String username;
  String email;
  String password;
  String pictureUrl;
  int gender;
  DateTime birthdate;
  Address address;
  bool activeStatus;
  bool verifiedStatus;
  DateTime dateCreated;

  User(
      {this.id,
      this.activeStatus,
      this.address,
      this.birthdate,
      this.dateCreated,
      this.email,
      this.gender,
      this.lastname,
      this.name,
      this.password,
      this.pictureUrl,
      this.username,
      this.verifiedStatus});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["_id"],
        activeStatus: json["activeStatus"],
        address: Address.fromJson(json["address"]),
        birthdate: DateTime.parse(json["birthdate"]),
        dateCreated: DateTime.parse(json["dateCreated"]),
        email: json["email"],
        gender: json["gender"],
        lastname: json["lastname"],
        name: json["name"],
        password: json["password"],
        pictureUrl: json["pictureUrl"],
        username: json["username"],
        verifiedStatus: json["verifiedStatus"]);
  }
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

List<User> userListFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<User>.from(jsonData.map((x) => User.fromJson(x)));
}
