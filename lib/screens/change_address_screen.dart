import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class ChangeAddressScreen extends StatefulWidget {
  @override
  _ChangeAddressScreenState createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Change Address",
          style: Styles.BLACK_TEXT,
        ),
      ),
      body: Center(child: Text("Change Address")),
    );
  }
}
