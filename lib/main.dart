import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/splash_screen.dart';
import 'package:solidarity_flutter_ui/utils/routes.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  runApp(SolidarityApp());
}

final primaryColor = Color(0xff4747d1);
final accentColor = Color(0xff2929a3);

class SolidarityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solidarity App',
      home: SplashScreen(),
      routes: Routes.routes,
      theme: ThemeData(
        // colors
        brightness: Brightness.light,
        primaryColor: primaryColor,
        accentColor: accentColor,
        //appbar theme,
        appBarTheme: AppBarTheme(
          color: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: primaryColor),
        ),
        // tabbar theme
        tabBarTheme: TabBarTheme(
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey,
        ),
      ),
    );
  }
}
