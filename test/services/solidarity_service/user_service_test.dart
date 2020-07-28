import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await SharedPrefs.init();

  var _login = LoginDTO(email: "semustafacevik@gmail.com", password: "c123123");
  await login(_login);
  User _user;

  group("Solidarity Service - User Service Test Functions", () {
    test("GET: getUserMe", () async {
      var result = await getUserMe();
      _user = result;
      expect(result.email, _login.email);
    });

    test("GET: getUserById", () async {
      var result = await getUserById(_user.id);
      expect(result.id, _user.id);
      expect(result.email, _user.email);
    });

    test("GET: getUserByUsername", () async {
      var result = await getUserByUsername(_user.username);
      expect(result.id, _user.id);
      expect(result.email, _user.email);
    });
  });
}
