import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/screens/home_screen.dart';
import 'package:solidarity_flutter_ui/screens/search_screen.dart';
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
    // TODO: constructor - address detail -> get user info
    //futurePostList = getPostsByFullAddress("Ödemiş-İzmir-Türkiye");
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
        title: _appBarItems(),
      );

  Widget _appBarItems() => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        children: <Widget>[
          CircleAvatar(backgroundImage: NetworkImage(user.pictureUrl)),
          Text("Solidarity Platform",
              style: Theme.of(context).textTheme.headline1)
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
