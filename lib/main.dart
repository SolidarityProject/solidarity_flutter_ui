import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/main_tabbar.dart';

void main() => runApp(SolidarityApp());

class SolidarityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Solidarity App',
        home: MainTabBar(),
        theme: ThemeData(
            // colors
            brightness: Brightness.light,
            primaryColor: Color(0xff12389b),
            accentColor: Color(0xff1818D5),
            // font family
            fontFamily:
                'Montserrat', // TODO : research best font family & colors
            // text themes
            textTheme: TextTheme(
              headline1: TextStyle(
                  letterSpacing: 1,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
              headline6: TextStyle(fontSize: 8.0, fontStyle: FontStyle.italic),
              bodyText1: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind'),
              bodyText2: TextStyle(
                  fontSize: 14.0, color: Colors.black54, fontFamily: 'Hind'),
            ),
            // appbar theme
            appBarTheme:
                AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
            // tabbar theme
            tabBarTheme: TabBarTheme(
              labelColor: Color(0xff12389b),
              unselectedLabelColor: Colors.grey,
            )));
  }
}
