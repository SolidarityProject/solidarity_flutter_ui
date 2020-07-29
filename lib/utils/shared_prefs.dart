import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';

class SharedPrefs {
  static SharedPreferences _prefsInstance;

  // singleton design pattern
  static init() async {
    if (_prefsInstance == null) {
      _prefsInstance = await SharedPreferences.getInstance();
    }
    return _prefsInstance;
  }

  static Future<void> saveToken(String token) async {
    return _prefsInstance.setString("token", token);
  }

  static Future<void> saveUser(String user) async {
    return _prefsInstance.setString("user", user);
  }

  static Future<void> login() async {
    return _prefsInstance.setBool('login', true);
  }

  static Future<void> sharedClear() async {
    return _prefsInstance.clear();
  }

  static String get getToken => _prefsInstance.getString("token") ?? null;
  static bool get getLogin => _prefsInstance.getBool('login') ?? false;
  static User get getUser =>
      userFromJson(_prefsInstance.getString("user") ?? null);
}
