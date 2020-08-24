import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/mixins/validation_mixin/change_password_validation_mixin.dart';
import 'package:solidarity_flutter_ui/models/dtos/change_password_dto.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

ThemeData _themeData;

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with ChangePasswordValidationMixin {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordAgainController = TextEditingController();

  bool _autoValidateStatus = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _buildScaffoldContainer(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 2,
      centerTitle: true,
      title: Text(
        "Change Password",
        style: Styles.BLACK_TEXT,
      ),
    );
  }

  Widget _buildScaffoldContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildOldPasswordTextFormField(),
          SizedBox(height: 20.0),
          _buildNewPasswordTextFormField(),
          SizedBox(height: 20.0),
          _buildNewPasswordAgainTextFormField(),
          SizedBox(height: 40.0),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _buildOldPasswordTextFormField() {
    return _buildTextFormField(
      "Current Password",
      _oldPasswordController,
      15,
      validateOldPassword,
      Icons.lock_outline,
      "Enter your current password",
      inputFormatters: _passwordInputFormatter(),
    );
  }

  Widget _buildNewPasswordTextFormField() {
    return _buildTextFormField(
      "New Password",
      _newPasswordController,
      15,
      validateNewPassword,
      Icons.lock,
      "Enter your new password",
      inputFormatters: _passwordInputFormatter(),
    );
  }

  Widget _buildNewPasswordAgainTextFormField() {
    return _buildTextFormField(
      "New Password Again",
      _newPasswordAgainController,
      15,
      validateNewPasswordAgain,
      Icons.lock,
      "Enter your new password again",
      inputFormatters: _passwordInputFormatter(),
    );
  }

  Widget _buildTextFormField(
    String labelText,
    TextEditingController controller,
    int maxLength,
    String validationMixin(String val),
    IconData icon,
    String hintText, {
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter> inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //* label text
        Text(labelText, style: Styles.TF_LABEL),

        SizedBox(height: 10.0),

        Container(
          alignment: Alignment.centerLeft,
          decoration: Styles.TF_BOXDEC,
          height: 90.0,

          //* text form field
          child: TextFormField(
            controller: controller,
            maxLength: maxLength,
            keyboardType: inputType,
            obscureText: true,
            inputFormatters: inputFormatters,
            autovalidate: _autoValidateStatus ? true : false,
            validator: validationMixin,
            style: Styles.BLACK_TEXT,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              prefixIcon: Icon(icon),
              hintText: hintText,
              hintStyle: Styles.TF_HINT,
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() => FlatButton(
        color: _themeData.accentColor,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            // create change password dto
            var _changePassword = ChangePasswordDTO(
              id: user.id,
              oldPassword: _oldPasswordController.text,
              newPassword: _newPasswordController.text,
            );

            // call changePassword service function
            await changePassword(_changePassword).then(
              (value) async {
                // success
                var alertDiaolog = AlertDialogOneButton(
                  title: "Success",
                  content: "Changed your password.",
                  okText: "OK",
                  okOnPressed: () {
                    Navigator.pop(context);
                  },
                );
                await showDialog(
                  context: context,
                  builder: (context) => alertDiaolog,
                );
              },
            ).catchError(
              (onError) async {
                // error
                var alertDiaolog = AlertDialogOneButton(
                  title: "OOPS!",
                  content: "Please check your current password.",
                  okText: "OK",
                  okOnPressed: () {},
                );
                await showDialog(
                  context: context,
                  builder: (context) => alertDiaolog,
                );
              },
            );
          } else {
            // not valid
            setState(() {
              _autoValidateStatus = true;
            });
          }
        },
        child: Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      );
}

List<TextInputFormatter> _passwordInputFormatter() {
  return [
    FilteringTextInputFormatter.deny(" "),
    LengthLimitingTextInputFormatter(15),
  ];
}
