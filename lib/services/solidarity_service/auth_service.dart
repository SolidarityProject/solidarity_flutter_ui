import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/dtos/check_available_email_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/check_available_username_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/register_dto.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "https://solidarity-backend.herokuapp.com/auth";

Future<bool> login(LoginDTO loginDTO) async {
  final response = await http.post(
    "$_apiUrl/login",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: loginToJson(loginDTO),
  );

  if (response.statusCode == 200) {
    final resJsonData = json.decode(response.body);
    final token = resJsonData["token"];
    SharedPrefs.saveToken(token);
    SharedPrefs.login();
    return true;
  } else {
    return false;
  }
}

Future<bool> register(RegisterDTO registerDTO) async {
  final response = await http.post(
    "$_apiUrl/register",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: registerToJson(registerDTO),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkAvailableEmail(
  CheckAvailableEmailDTO checkAvailableEmailDTO,
) async {
  final response = await http.post(
    "$_apiUrl/checkavailableemail",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: checkAvailableEmailToJson(checkAvailableEmailDTO),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkAvailableUsername(
  CheckAvailableUsernameDTO checkAvailableUsernameDTO,
) async {
  final response = await http.post(
    "$_apiUrl/checkavailableusername",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: checkAvailableUsernameToJson(checkAvailableUsernameDTO),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
