import 'package:solidarity_flutter_ui/utils/validation_rules.dart';

class RegisterValidationMixin {
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
}
