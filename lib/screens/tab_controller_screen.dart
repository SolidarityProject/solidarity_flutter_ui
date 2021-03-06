import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/models/country_model.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/screens/account_screen.dart';
import 'package:solidarity_flutter_ui/screens/home_screen.dart';
import 'package:solidarity_flutter_ui/screens/search_screen.dart';
import 'package:solidarity_flutter_ui/screens/starred_screen.dart';
import 'package:solidarity_flutter_ui/services/address_service/country_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/starred_post_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class TabControllerScreen extends StatefulWidget {
  @override
  _TabControllerScreenState createState() => _TabControllerScreenState();
}

Future<List<Post>> futurePostList;
Future<List<Post>> futureStarredPostList;
Future<List<Country>> futureCountryList;
List<dynamic> myStarredPosts;
String token;
User user;
Address searchAddress;

class _TabControllerScreenState extends State<TabControllerScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    token = SharedPrefs.getToken;
    user = SharedPrefs.getUser;
    searchAddress = user.address;
    myStarredPosts = user.starredPosts;
    futurePostList = getPostsByDistrictAddress(user.address.districtId);
    futureStarredPostList = getStarredPostsByUserId(user.id);
    futureCountryList = getAllCountry();
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

  Widget _appBar() {
    return AppBar(
      elevation: 2,
      centerTitle: true,
      leading: _appBarLeading(),
      title: _appBarTitleSelection(),
      actions: <Widget>[
        Container(
          height: 40,
          width: 40,
          child: InkWell(
              onTap: () {
                // TODO : district or city diaolog
              },
              child: Icon(Icons.settings)),
        )
      ],
    );
  }

  Widget _appBarLeading() {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: InkWell(
        onTap: () async => await Navigator.pushNamed(
          context,
          Constants.ROUTE_PROFILE,
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage(user.pictureUrl),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _appBarTitleSelection() {
    Widget _titleWidget;
    switch (_currentTabIndex) {
      case 0:
        _titleWidget = SizedBox(
          height: 40,
          width: 40,
          child: Image.asset("assets/images/icon_mobile.png"),
        );
        break;

      case 1:
        _titleWidget = Text("Search", style: Styles.BLACK_TEXT);
        break;

      case 2:
        _titleWidget = Text("Starred", style: Styles.BLACK_TEXT);
        break;

      case 3:
        _titleWidget = Text("Account", style: Styles.BLACK_TEXT);
        break;
    }
    return _titleWidget;
  }

  Widget _tabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeScreen(),
        SearchScreen(),
        StarredScreen(),
        AccountScreen()
      ],
    );
  }

  Widget _tabBarItems() {
    return TabBar(
      onTap: (value) => setState(() {
        _currentTabIndex = value;
      }),
      indicator: BoxDecoration(),
      tabs: <Widget>[
        Tab(icon: Icon(Icons.home, size: 28.0)),
        Tab(icon: Icon(Icons.search, size: 28.0)),
        Tab(icon: Icon(Icons.star, size: 28.0)),
        Tab(icon: Icon(Icons.dehaze, size: 28.0)),
      ],
    );
  }
}
