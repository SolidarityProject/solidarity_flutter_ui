import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

final _apiUrl = "https://solidarity-backend.herokuapp.com/users";

Future<User> getUserMe() async {
  final response =
      await http.get("$_apiUrl/me", headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    SharedPrefs.saveUser(response.body);
    SharedPrefs.login();
    return userFromJson(response.body);
  } else {
    SharedPrefs.sharedClear();
    throw Exception("Failed to load your profile.");
  }
}

Future<User> getUserById(String userId) async {
  final response = await http.get("$_apiUrl/getbyid/$userId",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception("Failed to load user.");
  }
}

Future<User> getUserByUsername(String username) async {
  final response = await http.get("$_apiUrl/getbyusername/$username",
      headers: {"token": SharedPrefs.getToken});

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception("Failed to load user.");
  }
}
