import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[_appBar, _tabBarItems, _expandedListView],
          )),
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_box),
      );

  Widget get _appBar => AppBar(
        elevation: 0,
        title: _appBarItems,
      );

  Widget get _appBarItems => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        children: <Widget>[
          CircleAvatar(
            child: Text("MC"),
          ),
          Text("Home", style: titleTextStyle)
        ],
      );

  Widget get _tabBarItems => TabBar(tabs: <Widget>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.search),
        ),
        Tab(
          icon: Icon(Icons.message),
        )
      ]);

  Widget get _expandedListView => Expanded(
        child: _listView,
      );

  Widget get _listView => ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Text("posts");
      });
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black);
