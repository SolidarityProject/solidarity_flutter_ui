import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/dtos/add_starred_post_dto.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "https://solidarity-backend.herokuapp.com/api/v1/starred-posts";

Future<bool> getMyStarredPosts() async {
  final response = await http.get(
    "$_apiUrl/my-starred-posts",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    SharedPrefs.saveStarredPosts(response.body);
    return true;
  } else {
    throw Exception("Failed to load your starred posts.");
  }
}

Future<List<Post>> getStarredPostsByUserId(String userId) async {
  final response = await http.get(
    "$_apiUrl/p/$userId",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load started posts.");
  }
}

// TODO : edit function name - getStarredUsersInfoByPostId
Future<List<User>> getStarredUsersInfoByPostId(String postId) async {
  final response = await http.get(
    "$_apiUrl/u/$postId",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return userListFromJson(response.body);
  } else {
    throw Exception("Failed to load users.");
  }
}

Future<bool> addStarredPost(AddStarredPostDTO addStarredPostDTO) async {
  final response = await http.post(
    "$_apiUrl",
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "token": SharedPrefs.getToken,
    },
    body: addStarredPostToJson(addStarredPostDTO),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to add started post.");
  }
}

Future<bool> deleteStarredPost(String deleteStarredPostId) async {
  final response = await http.delete(
    "$_apiUrl/$deleteStarredPostId",
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "token": SharedPrefs.getToken,
    },
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to delete started post.");
  }
}
