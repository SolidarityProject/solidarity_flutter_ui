import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/login_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/starred_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

import 'tab_controller_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initStateAsyncFunctions().then((_) {});
    super.initState();
  }

  Future<void> initStateAsyncFunctions() async {
    await getUserMe();
    await pageRotate();
  }

  Future pageRotate() async {
    Future.delayed(Duration(seconds: 2), () async {
      if (SharedPrefs.getLogin) {
        await getStarredPostMyPosts();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TabControllerScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 200,
              height: 230,
              child: Image.asset(
                "assets/images/icon_mobile_splash.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
