import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/mixins/validation_mixin/register_validation_mixin.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

ThemeData _themeData;

class _RegisterScreenState extends State<RegisterScreen>
    with RegisterValidationMixin {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  var _formTFHeight = 50.0;
  var _formTFHeightPW = 50.0;
  var _autoValidateStatus = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            _buildColorContainer(),
            _buildMainContainer(),
          ],
        ),
      ),
    );
  }

  Container _buildColorContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff9999e6),
            Color(0xff8484e1),
            Color(0xff6f6fdc),
            Color(0xff5b5bd7),
          ],
          stops: [0.1, 0.4, 0.7, 0.8],
        ),
      ),
    );
  }

  Container _buildMainContainer() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: 60.0,
          bottom: 20.0,
          left: 30.0,
          right: 30.0,
        ),
        child: _buildColumnContainer(),
      ),
    );
  }

  Column _buildColumnContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _appIconSizedBox(),
        SizedBox(height: 15.0),
        _signUpText(),
        SizedBox(height: 20.0),
        _buildNameTextFormField(),
        SizedBox(height: 20.0),
        _buildLastNameTextFormField(),
        SizedBox(height: 20.0),
        _buildUsernameTextFormField(),
        SizedBox(height: 20.0),
        _buildEmailTextFormField(),
        SizedBox(height: 20.0),
        _buildPasswordTextFormField(),
        SizedBox(height: 20.0),
        _buildRegisterButton(),
        SizedBox(height: 40.0),
        _buildSignInButton(),
      ],
    );
  }

  SizedBox _appIconSizedBox() {
    return SizedBox(
      height: 90,
      width: 90,
      child: Image.asset(
        "assets/images/icon_github.png",
        fit: BoxFit.contain,
      ),
    );
  }

  Text _signUpText() {
    return Text(
      "Sign Up",
      style: Styles.LOGIN_TITLE,
    );
  }

  Widget _buildNameTextFormField() {
    return _buildTextFormField(
      "Name",
      _nameController,
      50,
      validateName,
      // saveName,
      "N",
      "Enter your name",
      inputFormatters: nameInputFormat(),
    );
  }

  Widget _buildLastNameTextFormField() {
    return _buildTextFormField(
      "Last Name",
      _lastNameController,
      50,
      validateLastName,
      // saveName,
      "L",
      "Enter your last name",
      inputFormatters: nameInputFormat(),
    );
  }

  Widget _buildUsernameTextFormField() {
    return _buildTextFormField(
      "Username",
      _usernameController,
      20,
      validateUsername,
      // saveName,
      "U",
      "Enter your username",
      inputFormatters: usernameInputFormat(),
    );
  }

  Widget _buildEmailTextFormField() {
    return _buildTextFormField(
      "Email",
      _emailController,
      50,
      validateEmail,
      // saveName,
      "E",
      "Enter your email",
      inputType: TextInputType.emailAddress,
      icon: Icons.email,
      inputFormatters: emailInputFormat(),
    );
  }

  Widget _buildPasswordTextFormField() {
    return _buildTextFormField(
      "Password",
      _passwordController,
      16,
      validatePassword,
      // saveName,
      "P",
      "Enter your password",
      obscureText: true,
      icon: Icons.lock,
      inputFormatters: passwordInputFormat(),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          setState(() {
            _autoValidateStatus = true;
            _formTFHeight = 70;
            _formTFHeightPW = 90;
          });
        },
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          "REGISTER",
          style: Styles.LOGIN_BTN_TEXT,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: () async => await Navigator.pushReplacementNamed(
        context,
        Constants.ROUTE_LOGIN,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Already have an account? ",
              style: Styles.LOGIN_TEXTSPAN,
            ),
            TextSpan(
              text: "Sign In",
              style: Styles.LOGIN_SIGNUP_TEXT,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    String labelText,
    TextEditingController controller,
    int maxLength,
    String validationMixin(String val),
    //Function saveMixin,
    String iconText,
    String hintText, {
    bool obscureText = false,
    IconData icon,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter> inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //* label text
        Text(
          labelText,
          style: Styles.TF_LABEL_WHITE,
        ),

        SizedBox(height: 10.0),

        Container(
          alignment: Alignment.centerLeft,
          decoration: Styles.TF_BOXDEC,
          height: obscureText ? _formTFHeightPW : _formTFHeight,

          //* text form field
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLength: _autoValidateStatus ? maxLength : null,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            autovalidate: _autoValidateStatus ? true : false,
            validator: validationMixin,
            //onSaved: saveMixin,
            style: Styles.BLACK_TEXT,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              prefixIcon: CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: _themeData.accentColor,
                child: icon != null
                    ? Icon(icon)
                    : Text(
                        iconText[0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
              ),
              hintText: hintText,
              hintStyle: Styles.TF_HINT,
            ),
          ),
        ),
      ],
    );
  }
}
