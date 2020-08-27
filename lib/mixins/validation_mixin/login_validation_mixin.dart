import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/utils/validation_rules.dart';

class LoginValidationMixin {
  //* validation functions

  String validateEmail(String value) {
    return ValidationRules.validateEmail(value);
  }

  String validatePassword(String value) {
    return ValidationRules.validateOldPassword(value);
  }

  //* text input format functions

  List<TextInputFormatter> emailInputFormat() {
    return [
      ValidationRules.nonSpaceInputFormat(),
      ValidationRules.maxLengthInputFormat(50),
    ];
  }

  List<TextInputFormatter> passwordInputFormat() {
    return [
      ValidationRules.nonSpaceInputFormat(),
      ValidationRules.maxLengthInputFormat(15),
    ];
  }
}
