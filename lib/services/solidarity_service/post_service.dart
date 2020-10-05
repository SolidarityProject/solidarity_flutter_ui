import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/dtos/post_detail_dto.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "https://solidarity-backend.herokuapp.com/api/v1/posts";

Future<Post> getPostById(String postId) async {
  final response = await http.get(
    "$_apiUrl/$postId",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return postFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<PostDetailDTO> getPostDetailById(String postId) async {
  final response = await http.get(
    "$_apiUrl/$postId/details",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return postDetailFromJson(response.body);
  } else {
    throw Exception("Failed to load post detail.");
  }
}

Future<List<Post>> getPostsByUserId(String userId) async {
  final response = await http.get(
    "$_apiUrl/u/$userId",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<List<Post>> getPostsByDistrictAddress(String districtId) async {
  final response = await http.get(
    "$_apiUrl/district/$districtId",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<List<Post>> getPostsByProvinceAddress(String provinceId) async {
  final response = await http.get(
    "$_apiUrl/province/$provinceId",
    headers: {"token": SharedPrefs.getToken},
  );

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<List<Post>> getPostsByProvinceAddressForFree(String provinceId) async {
  final response = await http.get(
    "$_apiUrl/free/$provinceId",
  );

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}
