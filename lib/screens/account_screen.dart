import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listView(),
    );
  }

  Widget _listView() => ListView(
        children: <Widget>[
          _listViewProfileCard(),
          _listViewCard(
            Icons.lock_outline,
            "Change Password",
            _changePasswordFunc,
          ),
          _listViewCard(
            Icons.power_settings_new,
            "Log out",
            _logoutFunc,
          ),
        ],
      );

  Widget _listViewProfileCard() => InkWell(
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              backgroundImage: NetworkImage(user.pictureUrl),
            ),
            title: Text("My Profile"),
            subtitle: Text(
                "${user.name + " " + user.lastname}  \n${user.address.district + " / " + user.address.province}"),
            isThreeLine: true,
          ),
        ),
        onTap: () {
          _myProfileFunc();
        },
      );

  Widget _listViewCard(IconData icon, String title, Function onTapFunc) => Card(
        child: _cardInkwell(icon, title, onTapFunc),
      );

  Widget _cardInkwell(IconData icon, String title, Function onTapFunc) =>
      InkWell(
        child: _cardTouchableListTile(icon, title),
        onTap: () {
          onTapFunc();
        },
      );

  Widget _cardTouchableListTile(IconData icon, String title) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(icon),
        ),
        title: Text(title),
      );

  void _myProfileFunc() {
    Navigator.pushNamed(context, Constants.ROUTE_PROFILE);
  }

  void _changePasswordFunc() {
    print("tap -> change password");
  }

  void _logoutFunc() {
    print("tap -> log out");
  }
}
