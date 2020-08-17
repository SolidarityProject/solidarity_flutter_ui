import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/splash_screen.dart';
import 'package:solidarity_flutter_ui/utils/routes.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  runApp(SolidarityApp());
}

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
        primaryColor: Color(0xff4747d1),
        accentColor: Color(0xff2929a3),
        //appbar theme,
        appBarTheme: AppBarTheme(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        // tabbar theme
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xff4747d1),
          unselectedLabelColor: Colors.grey,
        ),
      ),
    );
  }
}
