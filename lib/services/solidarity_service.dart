import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/post.dart';

final _apiUrl = "http://192.168.42.94:2020";

Future<Post> getPostById(String id) async {
  final response = await http.get("$_apiUrl/posts/getbyid/$id");

  if (response.statusCode == 200) {
    return postFromJson(response.body);
  } else {
    throw Exception("Failed to load post.");
  }
}

Future<List<Post>> getPostsByFullAddress(String fullAddress) async {
  final response =
      await http.get("$_apiUrl/posts/getbyfulladdress?fa=$fullAddress");

  if (response.statusCode == 200) {
    return postListFromJson(response.body);
  } else {
    throw Exception("Failed to load posts.");
  }
}
