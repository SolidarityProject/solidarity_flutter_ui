import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';

class ProfileValidationMixin {
  String validateName(String value) {
    if (value.startsWith(" ")) {
      return "Name mustn't start space";
    } else if (value.contains("  ")) {
      return "Name mustn't be contains one more than space";
    } else if (value.isEmpty) {
      return "Please enter your name";
    } else if (value.length < 2) {
      return "Name must be at least 2 characters";
    } else {
      return null;
    }
  }

  void saveName(String newValue) {
    user.name = newValue;
  }

  String validateLastName(String value) {
    if (value.startsWith(" ")) {
      return "Last name mustn't start space";
    } else if (value.contains("  ")) {
      return "Name mustn't be contains one more than space";
    } else if (value.isEmpty) {
      return "Please enter your last name";
    } else if (value.length < 2) {
      return "Last name must be at least 2 characters";
    } else {
      return null;
    }
  }

  void saveLastName(String newValue) {
    user.lastname = newValue;
  }

  String validateUsername(String value) {
    if (value.isEmpty) {
      return "Please enter your username";
    } else if (value.contains(" ")) {
      return "Username mustn't be contains space";
    } else if (value.length < 4) {
      return "Username must be at least 4 characters";
    } else if (!_usernameValidControl(value)) {
      return "Please check your username format";
    } else {
      return null;
    }
  }

  void saveUsername(String newValue) {
    user.username = newValue;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    } else if (value.contains(" ")) {
      return "Email mustn't be contains space";
    } else if (!_emailValidControl(value)) {
      return "Please check your email format";
    } else {
      return null;
    }
  }

  void saveEmail(String newValue) {
    user.email = newValue;
  }
}

bool _usernameValidControl(String username) {
  Pattern usernamePattern = r"^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$";
  bool usernameValid = RegExp(usernamePattern).hasMatch(username);

  return usernameValid;
}

bool _emailValidControl(String email) {
  Pattern emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
  bool emailValid = RegExp(emailPattern).hasMatch(email);

  return emailValid;
}
