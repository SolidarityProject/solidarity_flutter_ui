import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/mixins/validation_mixin/change_password_validation_mixin.dart';
import 'package:solidarity_flutter_ui/models/dtos/change_password_dto.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';
import 'package:solidarity_flutter_ui/widgets/label_text_form_field.dart';

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
    return LabelTextFormField(
      formHeight: 90,
      obscureStatus: true,
      autoValidateStatus: _autoValidateStatus,
      labelText: "Current Password",
      labelTextStyle: Styles.TF_LABEL,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _oldPasswordController,
      maxLength: 15,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.lock_outline,
      hintText: "e.g. currentPW123*",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: passwordInputFormatter(),
      validationMixin: (_) => validateOldPassword(_),
    );
  }

  Widget _buildNewPasswordTextFormField() {
    return LabelTextFormField(
      formHeight: 90,
      obscureStatus: true,
      autoValidateStatus: _autoValidateStatus,
      labelText: "New Password",
      labelTextStyle: Styles.TF_LABEL,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _newPasswordController,
      maxLength: 15,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.lock,
      hintText: "e.g. newPW123*",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: passwordInputFormatter(),
      validationMixin: (_) => validateNewPassword(_),
    );
  }

  Widget _buildNewPasswordAgainTextFormField() {
    return LabelTextFormField(
      formHeight: 90,
      obscureStatus: true,
      autoValidateStatus: _autoValidateStatus,
      labelText: "New Password Again",
      labelTextStyle: Styles.TF_LABEL,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _newPasswordAgainController,
      maxLength: 15,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.lock,
      hintText: "e.g. newPW123*",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: passwordInputFormatter(),
      validationMixin: (_) => validateNewPasswordAgain(_),
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
