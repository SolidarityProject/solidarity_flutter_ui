import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';
import 'package:solidarity_flutter_ui/widgets/label_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

ThemeData _themeData;

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _formHeight = 50.0;
  var _autoValidateStatus = false;

  @override
  void dispose() {
    _emailController.dispose();
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
        padding: EdgeInsets.fromLTRB(30, 60, 30, 20),
        child: _buildForm(),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _appIconSizedBox(),
          SizedBox(height: 15.0),
          _signInText(),
          SizedBox(height: 20.0),
          _buildEmailTextFormField(),
          SizedBox(height: 30.0),
          _buildPasswordTextFormField(),
          SizedBox(height: 25.0),
          _buildLoginButton(),
          SizedBox(height: 80.0),
          _buildSignupButton()
        ],
      ),
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

  Text _signInText() {
    return Text(
      "Sign In",
      style: Styles.LOGIN_TITLE,
    );
  }

  Widget _buildEmailTextFormField() {
    return LabelTextFormField(
      formHeight: _formHeight,
      autoValidateStatus: _autoValidateStatus,
      labelText: "Email",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _emailController,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.email,
      hintText: "Enter your email",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputType: TextInputType.emailAddress,
      //inputFormatters: //,
      //validationMixin: ,
    );
  }

  Widget _buildPasswordTextFormField() {
    return LabelTextFormField(
      formHeight: _formHeight,
      obscureStatus: true,
      autoValidateStatus: _autoValidateStatus,
      labelText: "Password",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _passwordController,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.lock,
      hintText: "Enter your password",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      //inputFormatters: //,
      //validationMixin: ,
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text("LOGIN", style: Styles.LOGIN_BTN_TEXT),
        onPressed: () async {
          var _loginDTO = LoginDTO(
            email: _emailController.text,
            password: _passwordController.text,
          );

          var result = await login(_loginDTO);

          if (result) {
            await getUserMe();
            Navigator.of(context).pushNamedAndRemoveUntil(
              Constants.ROUTE_TABCONTROLLER,
              (Route<dynamic> route) => false,
            );
          } else {
            var alertDiaolog = AlertDialogOneButton(
              title: "OOPS!",
              content: "Please check your email or password.",
              okText: "OK",
              okOnPressed: () {},
            );
            showDialog(
              context: context,
              builder: (context) => alertDiaolog,
            );
          }
        },
      ),
    );
  }

  Widget _buildSignupButton() {
    return GestureDetector(
      onTap: () async => await Navigator.pushNamed(
        context,
        Constants.ROUTE_REGISTER,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don\'t have an account? ",
              style: Styles.LOGIN_TEXTSPAN,
            ),
            TextSpan(
              text: 'Sign Up',
              style: Styles.LOGIN_SIGNUP_TEXT,
            ),
          ],
        ),
      ),
    );
  }
}
