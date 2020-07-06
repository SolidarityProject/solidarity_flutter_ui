import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/login/login.dart';
//import 'package:solidarity_flutter_ui/screens/main_tabbar.dart';

void main() => runApp(SolidarityApp());

class SolidarityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solidarity App',
      home: LoginScreen(),
      theme: ThemeData(
        // colors
        brightness: Brightness.light,
        primaryColor: Color(0xff12389b),
        accentColor: Color(0xff1818D5),
        // font family
        fontFamily: 'Montserrat', // TODO : research best font family & colors
        // text themes
        textTheme: TextTheme(
            headline1: TextStyle(
                letterSpacing: 1,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.black),
            headline6: TextStyle(fontSize: 8.0, fontStyle: FontStyle.italic),
            bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontSize: 14.0, color: Colors.grey, fontFamily: 'Hind'),
            overline: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                color: Color(0xff1818D5))),
        // appbar theme
        appBarTheme:
            AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
        // tabbar theme
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xff12389b),
          unselectedLabelColor: Colors.grey,
        ),
      ),
    );
  }
}
