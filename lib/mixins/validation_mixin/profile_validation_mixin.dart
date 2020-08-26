import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/utils/validation_rules.dart';

class ProfileValidationMixin {
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

  //* on saved functions

  void saveName(String newValue) {
    user.name = newValue;
  }

  void saveLastName(String newValue) {
    user.lastname = newValue;
  }

  void saveUsername(String newValue) {
    user.username = newValue;
  }

  void saveEmail(String newValue) {
    user.email = newValue;
  }
}
