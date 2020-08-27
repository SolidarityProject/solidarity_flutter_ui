import 'package:flutter/services.dart';

class ValidationRules {
  static String validateName(String value) {
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

  static String validateLastName(String value) {
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

  static String validateBirthdate(String value) {
    if (value.isEmpty) {
      return "Please enter your birthdate";
    } else {
      return null;
    }
  }

  static String validateUsername(String value) {
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

  static String validateEmail(String value) {
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

  static String validateOldPassword(String value) {
    if (value.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else {
      return null;
    }
  }

  static String _tempPassword;

  static String validateNewPassword(String value) {
    if (value.isEmpty) {
      return "Please enter your new password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!_passwordValidControl(value)) {
      return "Password must contain at least one lowercase letter,\none uppercase letter, one number and one special\ncharacter.";
    } else {
      _tempPassword = value;
      return null;
    }
  }

  static String validateNewPasswordAgain(String value) {
    if (value.isEmpty) {
      return "Please enter your new password again";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!_passwordValidControl(value)) {
      return "Password must contain at least one lowercase letter,\none uppercase letter, one number and one special\ncharacter.";
    } else if (_tempPassword != value) {
      return "New password and repeat password don't match.";
    } else {
      return null;
    }
  }

  //* text input formatter

  static TextInputFormatter nameInputFormat() =>
      FilteringTextInputFormatter.allow(
        (RegExp("[a-zA-ZığüşöçİĞÜŞÖÇ ]")),
      );

  static TextInputFormatter nonSpaceInputFormat() =>
      FilteringTextInputFormatter.deny(" ");

  //* valid control functions -> regex

  static bool _usernameValidControl(String username) {
    Pattern usernamePattern = r"^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$";
    bool usernameValid = RegExp(usernamePattern).hasMatch(username);

    return usernameValid;
  }

  static bool _emailValidControl(String email) {
    Pattern emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,3}$";
    bool emailValid = RegExp(emailPattern).hasMatch(email);

    return emailValid;
  }

  static bool _passwordValidControl(String password) {
    Pattern passwordPattern =
        r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[$&+,:;=?@#|<>.^\_*()%!-]).{6,15}$";
    bool passwordValid = RegExp(passwordPattern).hasMatch(password);

    return passwordValid;
  }
}
