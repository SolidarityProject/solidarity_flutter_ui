import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/dtos/add_starred_post_dto.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/models/starred_post_model.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "http://localhost:2020/starredposts";

Future<List<dynamic>> getStarredPostMyPosts() async {
  final response = await http.get("$_apiUrl/getmystarredposts",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Failed to load starred posts.");
  }
}

Future<StarredPost> getStarredPostById(String starredPostId) async {
  final response = await http.get("$_apiUrl/getbyid/$starredPostId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return starredPostFromJson(response.body);
  } else {
    throw Exception("Failed to load starred post.");
  }
}

Future<List<Post>> getStarredPostsByUserId(String userId) async {
  final response = await http.get("$_apiUrl/getbyuserid/$userId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load started posts.");
  }
}

Future<List<User>> getStarredPostUsersByPostId(String postId) async {
  final response = await http.get("$_apiUrl/getbyuserid/$postId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return userListFromJson(response.body);
  } else {
    throw Exception("Failed to load users.");
  }
}

Future<bool> addStarredPost(AddStarredPostDTO addStarredPostDTO) async {
  final response = await http.post(
    "$_apiUrl/add",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: addStarredPostToJson(addStarredPostDTO),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to add started post.");
  }
}

Future<bool> deleleStarredPost(String deleteStarredPostId) async {
  final response = await http.delete(
    "$_apiUrl/delete/$deleteStarredPostId",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to delete started post.");
  }
}
