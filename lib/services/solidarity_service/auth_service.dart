import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "http://solidarity-backend.herokuapp.com/auth";

Future<bool> login(LoginDTO login) async {
  final response = await http.post(
    "$_apiUrl/login",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: loginToJson(login),
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
