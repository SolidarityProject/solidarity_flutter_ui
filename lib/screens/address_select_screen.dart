import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/color_container.dart';

class AddressSelectScreen extends StatefulWidget {
  @override
  _AddressSelectScreenState createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            ColorContainer(),

          ],
        )
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 2,
      centerTitle: true,
      title: Text(
        "Address Select",
        style: Styles.BLACK_TEXT,
      ),
    );
  }
}
