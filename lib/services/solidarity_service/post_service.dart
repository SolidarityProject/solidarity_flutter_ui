import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "http://solidarity-backend.herokuapp.com/posts";

Future<List<Post>> getPostsByFullAddress(String fullAddress) async {
  final response =
      await http.get("$_apiUrl/posts/getbyfulladdress?fa=$fullAddress");

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}
