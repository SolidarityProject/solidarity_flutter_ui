import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/screens/home_screen.dart';
import 'package:solidarity_flutter_ui/screens/search_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/solidarity_service.dart';

class MainTabBar extends StatefulWidget {
  @override
  _MainTabBarState createState() => _MainTabBarState();
}

Future<List<Post>> futurePostList;

class _MainTabBarState extends State<MainTabBar> {
  @override
  void initState() {
    // TODO: constructor - address detail -> get user info
    futurePostList = getPostsByFullAddress("Ödemiş-İzmir-Türkiye");
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
          CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT312H_JteV3xrSnnTeZm3TFUPAaG85vKKTWmjIyEsohKA5SvEe&usqp=CAU")),
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
