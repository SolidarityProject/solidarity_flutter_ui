import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/screens/home_screen.dart';
import 'package:solidarity_flutter_ui/screens/search_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

class MainTabBar extends StatefulWidget {
  @override
  _MainTabBarState createState() => _MainTabBarState();
}

Future<List<Post>> futurePostList;
String token;
User user;

class _MainTabBarState extends State<MainTabBar> {
  @override
  void initState() {
    token = SharedPrefs.getToken;
    user = SharedPrefs.getUser;
    futurePostList = getPostsByFullAddress(user.address.districtId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[_expandedTabBarView(), _tabBarItems()],
          )),
    );
  }

  Widget _appBar() => AppBar(
        elevation: 0,
        title: Text("Solidarity Platform",
            style: Theme.of(context).textTheme.headline1),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: CircleAvatar(backgroundImage: NetworkImage(user.pictureUrl)),
        ),
        actions: <Widget>[
          FlatButton( 
              onPressed: () { // TODO : comfirm dialog
                SharedPrefs.sharedClear();
                Navigator.of(context)
                    .pushReplacementNamed(Constants.ROUTE_LOGIN);
              },
              child: Icon(Icons.power_settings_new))
        ],
      );

  Widget _expandedTabBarView() => Expanded(
          child: TabBarView(
        children: <Widget>[HomeScreen(), SearchScreen()],
      ));

  Widget _tabBarItems() => TabBar(tabs: <Widget>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.search),
        ),
      ]);
}
