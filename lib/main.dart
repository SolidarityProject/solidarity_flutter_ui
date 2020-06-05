import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/home/home.dart';

void main() => runApp(SolidarityApp());

class SolidarityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solidarity App',
      home: HomeScreen(),
      theme: ThemeData.light().copyWith(
          appBarTheme:
              AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          )),
    );
  }
}
