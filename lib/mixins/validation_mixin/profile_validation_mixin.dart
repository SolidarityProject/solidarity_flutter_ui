class ProfileValidationMixin {
  String validateName(String value) {
    if (value.isEmpty) {
      return "Please enter your name";
    } else if (value.length < 2) {
      return "Name must be at least 2 characters";
    }
    return null;
  }

  String validateLastName(String value) {
    if (value.isEmpty) {
      return "Please enter your last name";
    }

    return null;
  }

  String validateUsername(String value) {
    if (value.isEmpty) {
      return "Please enter your username";
    }

    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    }

    return null;
  }
}
