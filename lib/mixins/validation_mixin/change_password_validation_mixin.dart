import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/utils/validation_rules.dart';

class ChangePasswordValidationMixin {
  //* validation functions
  String validateOldPassword(String value) {
    return ValidationRules.validateOldPassword(value);
  }

  String validateNewPassword(String value) {
    return ValidationRules.validateNewPassword(value);
  }

  String validateNewPasswordAgain(String value) {
    return ValidationRules.validateNewPasswordAgain(value);
  }

  //* text input format function

  List<TextInputFormatter> passwordInputFormatter() {
    return [
      ValidationRules.nonSpaceInputFormat(),
    ];
  }
}
