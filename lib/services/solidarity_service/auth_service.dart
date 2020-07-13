import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';

final _apiUrl = "http://solidarity-backend.herokuapp.com/auth";

Future<String> login(Login login) async {
  final response = await http.post(
    "$_apiUrl/login",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: loginToJson(login),
  );

  if (response.statusCode == 200) {
    final resJsonData = json.decode(response.body);
    return (resJsonData["token"]);
  } else {
    throw Exception("Failed to login.");
  }
}
