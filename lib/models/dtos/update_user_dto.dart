import 'dart:convert';

import 'package:solidarity_flutter_ui/models/address_model.dart';

class UpdateUserDTO {
  String id;
  String name;
  String lastname;
  String username;
  String email;
  String pictureUrl;
  int gender;
  DateTime birthdate;
  Address address;

  UpdateUserDTO({
    this.id,
    this.address,
    this.birthdate,
    this.email,
    this.gender,
    this.lastname,
    this.name,
    this.pictureUrl,
    this.username,
  });

  Map<String, dynamic> toJson() => {
        "_id": this.id,
        "address": this.address,
        "birthdate": this.birthdate.toIso8601String(),
        "email": this.email,
        "gender": this.gender,
        "lastname": this.lastname,
        "name": this.name,
        "pictureUrl": this.pictureUrl,
        "username": this.username,
      };
}

String updateUserToJson(UpdateUserDTO data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
