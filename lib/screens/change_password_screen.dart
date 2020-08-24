import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

ThemeData _themeData;

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordAgainController = TextEditingController();

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
      "Password",
      _oldPasswordController,
      15,
      // validateName,
      //saveName,
      Icons.lock,
      "Enter your password",
      //inputFormatters: _nameInputFormat(),
    );
  }

  Widget _buildNewPasswordTextFormField() {
    return _buildTextFormField(
      "New Password",
      _newPasswordController,
      15,
      //validateLastName,
      //saveLastName,
      Icons.lock,
      "Enter your new password",
      //inputFormatters: _nameInputFormat(),
    );
  }

  Widget _buildNewPasswordAgainTextFormField() {
    return _buildTextFormField(
      "New Password Again",
      _newPasswordAgainController,
      15,
      // validateUsername,
      //saveUsername,
      Icons.lock,
      "Enter your new password again",
      //  inputFormatters: _usernameInputFormat(),
    );
  }

  Widget _buildTextFormField(
    String labelText,
    TextEditingController controller,
    int maxLength,
    // String validationMixin(String val),
    // Function saveMixin,
    IconData icon,
    String hintText, {
    TextInputType inputType = TextInputType.text,
    //List<TextInputFormatter> inputFormatters,
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
          height: 70.0,

          //* text form field
          child: TextFormField(
            controller: controller,
            maxLength: maxLength,
            keyboardType: inputType,
            obscureText: true,
            //inputFormatters: inputFormatters,
            autovalidate: true,
            //validator: validationMixin,
            //onSaved: saveMixin,
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
        onPressed: () {},
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
