import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/screens/home_screen.dart';
import 'package:solidarity_flutter_ui/screens/search_screen.dart';
import 'package:solidarity_flutter_ui/screens/starred_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

class TabControllerScreen extends StatefulWidget {
  @override
  _TabControllerScreenState createState() => _TabControllerScreenState();
}

Future<List<Post>> futurePostList;
Future<List<Post>> futureStarredPostList;
String token;
User user;

class _TabControllerScreenState extends State<TabControllerScreen> {
  @override
  void initState() {
    token = SharedPrefs.getToken;
    user = SharedPrefs.getUser;
    futurePostList = getPostsByFullAddress(user.address.districtId);
    futureStarredPostList = futurePostList; // TODO : service
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: _appBar(),
        body: _tabBarView(),
        bottomNavigationBar: _tabBarItems(),
      ),
    );
  }

  Widget _appBar() => AppBar(
        elevation: 0,
        centerTitle: true,
        title: SizedBox(
          height: 40,
          width: 40,
          child: Image.asset("assets/images/icon_mobile.png"),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.pictureUrl),
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                // TODO : comfirm dialog
                SharedPrefs.sharedClear();
                Navigator.of(context)
                    .pushReplacementNamed(Constants.ROUTE_LOGIN);
              },
              child: Icon(Icons.power_settings_new))
        ],
      );

  Widget _tabBarView() => TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          SearchScreen(),
          StarredScreen(), // TODO : stared & details screen
          SearchScreen()
        ],
      );

  Widget _tabBarItems() => TabBar(
        indicator: BoxDecoration(),
        tabs: <Widget>[
          Tab(icon: Icon(Icons.home, size: 28.0)),
          Tab(icon: Icon(Icons.search, size: 28.0)),
          Tab(icon: Icon(Icons.star, size: 28.0)),
          Tab(icon: Icon(Icons.dehaze, size: 28.0)),
        ],
      );
}
