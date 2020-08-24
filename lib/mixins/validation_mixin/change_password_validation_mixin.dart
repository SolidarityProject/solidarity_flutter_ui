class ChangePasswordValidationMixin {
  String validateOldPassword(String value) {
    if (value.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else {
      return null;
    }
  }

  String _tempPassword;

  String validateNewPassword(String value) {
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

  String validateNewPasswordAgain(String value) {
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

  bool _passwordValidControl(String password) {
    Pattern passwordPattern =
        r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[$&+,:;=?@#|<>.^\_*()%!-]).{6,15}$";
    bool passwordValid = RegExp(passwordPattern).hasMatch(password);

    return passwordValid;
  }
}
