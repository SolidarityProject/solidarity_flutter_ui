import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

ThemeData _themeData;

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
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
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 60.0,
                    bottom: 20.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: Image.asset(
                          "assets/images/icon_github.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Sign In',
                        style: signInTextStyle,
                      ),
                      SizedBox(height: 20.0),
                      _buildTextField(
                        "Email",
                        _emailController,
                        false,
                        TextInputType.emailAddress,
                        Icons.email,
                        "Enter your email",
                      ),
                      SizedBox(height: 30.0),
                      _buildTextField(
                        "Password",
                        _passwordController,
                        true,
                        TextInputType.visiblePassword,
                        Icons.lock,
                        "Enter your password",
                      ),
                      SizedBox(height: 25.0),
                      _buildLoginButton(),
                      SizedBox(height: 80.0),
                      _buildSignupButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String labelText,
    TextEditingController controller,
    bool obscureStatus,
    TextInputType inputType,
    IconData iconData,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: Styles.TF_LABEL_WHITE,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: Styles.TF_BOXDEC,
          height: 50.0,
          child: TextField(
            controller: controller,
            obscureText: obscureStatus,
            keyboardType: inputType,
            style: Styles.BLACK_TEXT,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                iconData,
                color: _themeData.accentColor,
              ),
              hintText: hintText,
              hintStyle: Styles.TF_HINT,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          login(
            LoginDTO(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ).then((result) async {
            if (result) {
              await getUserMe();
              Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.ROUTE_TABCONTROLLER,
                (Route<dynamic> route) => false,
              );
            } else {
              var alertDiaologOneButton = AlertDialogOneButton(
                title: "OOPS!",
                content: "Check your email or password.",
                okText: "OK",
                okOnPressed: () {},
              );
              showDialog(
                context: context,
                builder: (context) => alertDiaologOneButton,
              );
            }
          });
        },
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: loginTextStyle,
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account? ',
              style: signUpTextSpanTextStyle,
            ),
            TextSpan(
              text: 'Sign Up',
              style: signUpTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

final signInTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

final loginTextStyle = TextStyle(
  color: _themeData.accentColor,
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

final signUpTextSpanTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
);

final signUpTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);
