import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/models/dtos/check_available_email_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/check_available_username_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/register_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await SharedPrefs.init();

  final _login = LoginDTO(
    email: "testuser_flutter@solidarity.org",
    password: "tU123123.",
  );

  group("Solidarity Service - Auth Service Test Functions", () {
    test("login", () async {
      var result = await login(_login);

      expect(result, true);
    });

    test("register", () async {
      final _random = Random();
      final _randomNumber = _random.nextInt(999);

      final _address = Address(
        country: "Türkiye",
        countryId: "5eef52787e2213196405352e",
        province: "İzmir",
        provinceId: "5eef530e7e22131964053531",
        district: "Ödemiş",
        districtId: "5eef567d7e2213196405353f",
      );

      final _register = RegisterDTO(
        address: _address,
        birthdate: DateTime.parse("1998-08-08"),
        email: "testuser_f$_randomNumber@solidarity.org",
        gender: 0,
        lastname: "User",
        name: "Test",
        password: "tU123123.",
        pictureUrl:
            "https://raw.githubusercontent.com/SolidarityProject/solidarity_icons/master/test_user.png",
        username: "testuser_f$_randomNumber",
      );

      var result = await register(_register);

      expect(result, true);
    });

    test("checkavailableemail", () async {
      var _checkAvailableEmail = CheckAvailableEmailDTO(
        email: "random345@xmail.com",
      );

      var result = await checkAvailableEmail(_checkAvailableEmail);

      expect(result, true);
    });

    //* because email exists
    test("checkavailableemail (error)", () async {
      var _checkAvailableEmailError = CheckAvailableEmailDTO(
        email: _login.email,
      );

      var result = await checkAvailableEmail(_checkAvailableEmailError);

      expect(result, false);
    });
    test("checkavailableusername", () async {
      var _checkAvailableUsername = CheckAvailableUsernameDTO(
        username: "randomUser12",
      );

      var result = await checkAvailableUsername(_checkAvailableUsername);

      expect(result, true);
    });

    //* because username exists
    test("checkavailableusername (error)", () async {
      var _checkAvailableUsernameError = CheckAvailableUsernameDTO(
        username: "semustafacevik",
      );

      var result = await checkAvailableUsername(_checkAvailableUsernameError);

      expect(result, false);
    });
  });
}
