import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

ThemeData _themeData;

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

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
            "Log Out",
            _logOutFunc,
          ),
        ],
      );

  Widget _listViewProfileCard() => InkWell(
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _themeData.primaryColor,
              child: Text(
                user.name[0] + user.lastname[0],
                style: Styles.WHITE_TEXT,
              ),
            ),
            title: Text("My Profile"),
            subtitle: Text(_myProfileInfoText()),
            isThreeLine: true,
          ),
        ),
        onTap: () async {
          await _myProfileFunc();
        },
      );

  String _myProfileInfoText() =>
      "${user.name + " " + user.lastname}\n${user.address.district + " / " + user.address.province}";

  Widget _listViewCard(IconData icon, String title, Function onTapFunc) => Card(
        child: _cardInkwell(icon, title, onTapFunc),
      );

  Widget _cardInkwell(IconData icon, String title, Function onTapFunc) =>
      InkWell(
        child: _cardTouchableListTile(icon, title),
        onTap: () async {
          await onTapFunc();
        },
      );

  Widget _cardTouchableListTile(IconData icon, String title) => ListTile(
        leading: CircleAvatar(
          backgroundColor: _themeData.primaryColor,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(title),
      );

  Future<void> _myProfileFunc() async {
    await Navigator.pushNamed(
      context,
      Constants.ROUTE_PROFILE,
    ).then((value) => setState(() {}));
  }

  Future<void> _changePasswordFunc() async {
    await Navigator.pushNamed(
      context,
      Constants.ROUTE_CHANGEPASSWORD,
    );
  }

  Future<void> _logOutFunc() async {
    var alertDialogTwoButtons = AlertDialogTwoButtons(
      title: "Are you sure?",
      content: "You will log out of your account.",
      noText: "Cancel",
      yesText: "Log out",
      noOnPressed: () {},
      yesOnPressed: () async {
        await SharedPrefs.sharedClear();
        await Navigator.pushReplacementNamed(context, Constants.ROUTE_LOGIN);
      },
    );
    await showDialog(
      context: context,
      builder: (context) => alertDialogTwoButtons,
    );
  }
}
