import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/home_screen.dart';
import 'package:solidarity_flutter_ui/screens/login_screen.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/screens/search_screen.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    Constants.ROUTE_LOGIN: (BuildContext context) => LoginScreen(),
    Constants.ROUTE_TABCONTROLLER: (BuildContext context) => TabControllerScreen(),
    Constants.ROUTE_HOME: (BuildContext context) => HomeScreen(),
    Constants.ROUTE_SEARCH: (BuildContext context) => SearchScreen(),
  };
}
