import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/models/dtos/change_password_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/update_user_dto.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "https://solidarity-backend.herokuapp.com/api/v1/users";

Future<User> getUserMe() async {
  final response = await http.get(
    "$_apiUrl/me/info",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    await SharedPrefs.saveUser(response.body);
    await SharedPrefs.login();
    return userFromJson(response.body);
  } else {
    SharedPrefs.sharedClear();
    throw Exception("Failed to load your profile.");
  }
}

Future<User> getUserById(String userId) async {
  final response = await http.get(
    "$_apiUrl/$userId",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception("Failed to load user.");
  }
}

Future<User> getUserByUsername(String username) async {
  final response = await http.get(
    "$_apiUrl/u/$username",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception("Failed to load user.");
  }
}

Future<User> updateUser(UpdateUserDTO updateUserDTO) async {
  final response = await http.put(
    "$_apiUrl",
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "token": SharedPrefs.getToken
    },
    body: updateUserToJson(updateUserDTO),
  );

  if (response.statusCode == 200) {
    await SharedPrefs.saveUser(response.body);
    return userFromJson(response.body);
  } else {
    throw Exception("Failed to update user.");
  }
}

// TODO : PATCH -> backend - change addreess

Future<User> changeUserAddress(Address address) async {
  User user = SharedPrefs.getUser;
  UpdateUserDTO updateUserDTO = UpdateUserDTO(
    address: address,
    id: user.id,
    birthdate: user.birthdate,
    email: user.email,
    gender: user.gender,
    lastname: user.lastname,
    name: user.name,
    pictureUrl: user.pictureUrl,
    username: user.username,
  );

  final response = await http.put(
    "$_apiUrl/",
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "token": SharedPrefs.getToken
    },
    body: updateUserToJson(updateUserDTO),
  );

  if (response.statusCode == 200) {
    await SharedPrefs.saveUser(response.body);
    return userFromJson(response.body);
  } else {
    throw Exception("Failed to update user.");
  }
}

Future<User> changePassword(ChangePasswordDTO changePasswordDTO) async {
  final response = await http.put(
    "$_apiUrl/${changePasswordDTO.id}/password",
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "token": SharedPrefs.getToken
    },
    body: changePasswordToJson(changePasswordDTO),
  );

  if (response.statusCode == 200) {
    await SharedPrefs.saveUser(response.body);
    return userFromJson(response.body);
  } else {
    throw Exception("Failed to change password.");
  }
}
