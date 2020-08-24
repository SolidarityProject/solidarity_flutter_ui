import 'dart:convert';

import 'package:solidarity_flutter_ui/models/address_model.dart';

class RegisterDTO {
  String name;
  String lastname;
  String username;
  String email;
  String password;
  String pictureUrl;
  int gender;
  DateTime birthdate;
  Address address;

  RegisterDTO({
    this.address,
    this.birthdate,
    this.email,
    this.gender,
    this.lastname,
    this.name,
    this.password,
    this.pictureUrl,
    this.username,
  });

  Map<String, dynamic> toJson() => {
        "address": this.address,
        "birthdate": this.birthdate.toIso8601String(),
        "email": this.email,
        "gender": this.gender,
        "lastname": this.lastname,
        "name": this.name,
        "password": this.password,
        "pictureUrl": this.pictureUrl,
        "username": this.username,
      };
}

String registerToJson(RegisterDTO data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
