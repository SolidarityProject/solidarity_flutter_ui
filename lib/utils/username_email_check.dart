import 'package:solidarity_flutter_ui/models/dtos/check_available_email_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/check_available_username_dto.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

Future<AlertDialogOneButton> usernameEmailCheckAlert(
    String username, String email) async {
  var availableEmail = await _checkAvailableEmail(email);
  var availableUsername =
      await _checkAvailableUsername(username);
  var alertDiaolog;

  //! error -> username & email not available
  if (!availableEmail && !availableUsername) {
    alertDiaolog = AlertDialogOneButton(
      title: "OOPS!",
      content:
          "This username ($username) and this email address ($email) are already in use.",
      okText: "OK",
      okOnPressed: () {},
    );
  }

  //! error -> username not available
  else if (!availableUsername) {
    alertDiaolog = AlertDialogOneButton(
      title: "OOPS!",
      content: "This username ($username) is already in use.",
      okText: "OK",
      okOnPressed: () {},
    );
  }

  //! error -> email not available
  else if (!availableEmail) {
    alertDiaolog = AlertDialogOneButton(
      title: "OOPS!",
      content: "This email ($email) is already in use.",
      okText: "OK",
      okOnPressed: () {},
    );
  }

  //* success
  else {
    alertDiaolog = null;
  }

  return alertDiaolog;
}

Future<bool> _checkAvailableEmail(String email) async {
  if (user.email != email) {
    return await checkAvailableEmail(
      CheckAvailableEmailDTO(email: email),
    );
  } else
    return true;
}

Future<bool> _checkAvailableUsername(String username) async {
  if (user.username != username) {
    return await checkAvailableUsername(
      CheckAvailableUsernameDTO(username: username),
    );
  } else
    return true;
}
