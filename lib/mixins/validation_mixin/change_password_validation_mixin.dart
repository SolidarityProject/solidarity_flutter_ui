import 'package:solidarity_flutter_ui/utils/validation_rules.dart';

class ChangePasswordValidationMixin {
  String validateOldPassword(String value) {
    return ValidationRules.validateOldPassword(value);
  }

  String validateNewPassword(String value) {
    return ValidationRules.validateNewPassword(value);
  }

  String validateNewPasswordAgain(String value) {
    return ValidationRules.validateNewPasswordAgain(value);
  }
}
