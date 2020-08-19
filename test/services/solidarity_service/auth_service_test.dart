import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/dtos/check_available_email_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await SharedPrefs.init();

  var _login = LoginDTO(email: "semustafacevik@gmail.com", password: "c123123");
  var _checkAvailableEmail = CheckAvailableEmailDTO(
    email: "random345@mail.com",
  );
  var _checkAvailableEmailError = CheckAvailableEmailDTO(
    email: _login.email,
  );
  group("Solidarity Service - Auth Service Test Functions", () {
    test("login", () async {
      var result = await login(_login);
      expect(result, true);
    });

    test("checkavailableemail", () async {
      var result = await checkAvailableEmail(_checkAvailableEmail);
      expect(result, true);
    });

    //* because email exists
    test("checkavailableemail (error)", () async {
      var result = await checkAvailableEmail(_checkAvailableEmailError);
      expect(result, false);
    });
  });
}
