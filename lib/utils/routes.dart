import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/account_screen.dart';
import 'package:solidarity_flutter_ui/screens/address_select_screen.dart';
import 'package:solidarity_flutter_ui/screens/change_address_screen.dart';
import 'package:solidarity_flutter_ui/screens/change_password_screen.dart';
import 'package:solidarity_flutter_ui/screens/home_screen.dart';
import 'package:solidarity_flutter_ui/screens/login_screen.dart';
import 'package:solidarity_flutter_ui/screens/profile_screen.dart';
import 'package:solidarity_flutter_ui/screens/register_screen.dart';
import 'package:solidarity_flutter_ui/screens/splash_screen.dart';
import 'package:solidarity_flutter_ui/screens/starred_screen.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/screens/search_screen.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    Constants.ROUTE_ACCOUNT: (BuildContext context) => AccountScreen(),
    Constants.ROUTE_ADDRESSSELECT: (BuildContext context) =>
        AddressSelectScreen(),
    Constants.ROUTE_CHANGEADDRESS: (BuildContext context) =>
        ChangeAddressScreen(),
    Constants.ROUTE_CHANGEPASSWORD: (BuildContext context) =>
        ChangePasswordScreen(),
    Constants.ROUTE_HOME: (BuildContext context) => HomeScreen(),
    Constants.ROUTE_LOGIN: (BuildContext context) => LoginScreen(),
    Constants.ROUTE_PROFILE: (BuildContext context) => ProfileScreen(),
    Constants.ROUTE_REGISTER: (BuildContext context) => RegisterScreen(),
    Constants.ROUTE_SEARCH: (BuildContext context) => SearchScreen(),
    Constants.ROUTE_SPLASH: (BuildContext context) => SplashScreen(),
    Constants.ROUTE_STARRED: (BuildContext context) => StarredScreen(),
    Constants.ROUTE_TABCONTROLLER: (BuildContext context) =>
        TabControllerScreen(),
  };
}
