import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Card(
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
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.lock_outline),
              ),
              title: Text("Change Password"),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.power_settings_new),
              ),
              title: Text("Log Out"),
            ),
          ),
        ],
      ),
    );
  }
}
