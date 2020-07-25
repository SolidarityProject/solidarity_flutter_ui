import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "http://solidarity-backend.herokuapp.com/posts";

Future<Post> getById(String postId) async {
  final response = await http.get("$_apiUrl/getbyid/$postId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return postFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<List<Post>> getByUserId(String userId) async {
  final response = await http.get("$_apiUrl/getbyuserid/$userId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<List<Post>> getByFullAddress(String districtId) async {
  final response = await http.get("$_apiUrl/getbyfulladdress/$districtId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<List<Post>> getByProvinceAddress(String provinceId) async {
  final response = await http.get("$_apiUrl/getbyprovinceaddress/$provinceId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}

Future<List<Post>> getByProvinceAddressForFree(String provinceId) async {
  final response =
      await http.get("$_apiUrl/free/getbyprovinceaddress/$provinceId");

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}
