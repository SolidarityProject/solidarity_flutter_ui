import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await SharedPrefs.init();

  var _login = LoginDTO(email: "semustafacevik@gmail.com", password: "c123123");
  group("Solidarity Service - Auth Service Test Functions", () {
    test("login", () async {
      var result = await login(_login);
      expect(result, true);
    });
  });
}
