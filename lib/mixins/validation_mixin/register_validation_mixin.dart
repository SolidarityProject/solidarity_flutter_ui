import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/utils/validation_rules.dart';

class RegisterValidationMixin {
  //* validation functions
  String validateName(String value) {
    return ValidationRules.validateName(value);
  }

  String validateLastName(String value) {
    return ValidationRules.validateLastName(value);
  }

  String validateUsername(String value) {
    return ValidationRules.validateUsername(value);
  }

  String validateEmail(String value) {
    return ValidationRules.validateEmail(value);
  }

  String validatePassword(String value) {
    return ValidationRules.validateNewPassword(value);
  }

  //* text input format functions

  List<TextInputFormatter> nameInputFormat() {
    return [
      ValidationRules.nameInputFormat(),
    ];
  }

  List<TextInputFormatter> usernameInputFormat() {
    return [
      ValidationRules.nonSpaceInputFormat(),
    ];
  }

  List<TextInputFormatter> emailInputFormat() {
    return [
      ValidationRules.nonSpaceInputFormat(),
    ];
  }

  List<TextInputFormatter> passwordInputFormat() {
    return [
      ValidationRules.nonSpaceInputFormat(),
    ];
  }
}
