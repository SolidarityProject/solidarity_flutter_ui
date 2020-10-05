import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/dtos/change_password_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/update_user_dto.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await SharedPrefs.init();

  final _login = LoginDTO(
    email: "testuser_flutter@solidarity.org",
    password: "tU123123.",
  );
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

    test("PUT: updateUser", () async {
      var _updateUser = UpdateUserDTO(
        id: _user.id,
        address: _user.address,
        birthdate: _user.birthdate,
        email: _user.email,
        gender: _user.gender,
        lastname: _user.lastname,
        name: "Test Upd",
        pictureUrl: _user.pictureUrl,
        username: _user.username,
      );

      var result = await updateUser(_updateUser);
      expect(result.id, _user.id);
      expect(result.name, _updateUser.name);
      expect(result.email, _user.email);
    });

    test("PUT: updateUser - update email & username", () async {
      var _updateUser = UpdateUserDTO(
        id: _user.id,
        address: _user.address,
        birthdate: _user.birthdate,
        email: "semustafacevik@solidarity.org",
        gender: _user.gender,
        lastname: _user.lastname,
        name: _user.name,
        pictureUrl: _user.pictureUrl,
        username: "semustafacevikupd",
      );

      var result = await updateUser(_updateUser);
      expect(result.id, _user.id);
      expect(result.email, _updateUser.email);
      expect(result.username, _updateUser.username);
    });

    // because username exists
    test("PUT: updateUser error (username exists)", () async {
      var _updateUser = UpdateUserDTO(
        id: _user.id,
        address: _user.address,
        birthdate: _user.birthdate,
        email: _user.email,
        gender: _user.gender,
        lastname: _user.lastname,
        name: _user.name,
        pictureUrl: _user.pictureUrl,
        username: "semustafacevik",
      );

      var error = false;
      var onErrorResult = "";

      await updateUser(_updateUser).catchError((onError) {
        onErrorResult = onError.toString();
        error = true;
      });
      expect(error, true);
      expect(onErrorResult, "Exception: Failed to update user.");
    });

    test("PUT: updateUser - re-update to first information", () async {
      var _updateUser = UpdateUserDTO(
        id: _user.id,
        address: _user.address,
        birthdate: _user.birthdate,
        email: _user.email,
        gender: _user.gender,
        lastname: _user.lastname,
        name: _user.name,
        pictureUrl: _user.pictureUrl,
        username: _user.username,
      );

      var result = await updateUser(_updateUser);
      expect(result.id, _user.id);
      expect(result.name, _user.name);
      expect(result.email, _user.email);
      expect(result.username, _user.username);
    });

    test("PUT: changePassword", () async {
      var _changePassword = ChangePasswordDTO(
        id: _user.id,
        oldPassword: "tU123123.",
        newPassword: "tU123123*",
      );

      var oldPass = _user.password;

      var result = await changePassword(_changePassword);
      expect(result.id, _user.id);
      expect(result.password != oldPass, true);
    });

    // because password is not valid
    test("PUT: changePassword error (password is not valid)", () async {
      var _changePassword = ChangePasswordDTO(
        id: _user.id,
        oldPassword: "tU123123*",
        newPassword: "t123",
      );

      var error = false;
      var onErrorResult = "";

      await changePassword(_changePassword).catchError((onError) {
        onErrorResult = onError.toString();
        error = true;
      });

      expect(error, true);
      expect(onErrorResult, "Exception: Failed to change password.");
    });

    test("PUT: changePassword (re-change to first information)", () async {
      var _changePassword = ChangePasswordDTO(
        id: _user.id,
        oldPassword: "tU123123*",
        newPassword: "tU123123.",
      );

      var oldPass = _user.password;

      var result = await changePassword(_changePassword);
      expect(result.id, _user.id);
      expect(result.password != oldPass, true);
    });
  });
}
