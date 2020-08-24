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

  // void saveName(String newValue) {
  //   user.name = newValue;
  // }

  String validateNewPassword(String value) {
    if (value.isEmpty) {
      return "Please enter your new password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else {
      return null;
    }
  }

  String validateNewPasswordAgain(String value) {
    if (value.isEmpty) {
      return "Please enter your new password again";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else {
      return null;
    }
  }
}
