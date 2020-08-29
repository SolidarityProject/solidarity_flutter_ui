import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/address_fields.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

ThemeData _themeData;
Address _selectedAddress;

class ChangeAddressScreen extends StatefulWidget {
  @override
  _ChangeAddressScreenState createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _buildAddressFields(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Change Address",
        style: Styles.BLACK_TEXT,
      ),
    );
  }

  AddressFields _buildAddressFields() {
    return AddressFields(
      futureCountryList: futureCountryList,
      labelTextStyle: Styles.TF_LABEL,
      buttonText: "Change Password",
      buttonTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      buttonColor: _themeData.accentColor,
      submitFunc: () => _submitTrueFunc(),
    );
  }

  void _submitTrueFunc() async {
    _selectedAddress = selectedAddressInfo;

    var alertDiaolog = AlertDialogOneButton(
      title: "Success",
      content:
          "Changed your address.\nYour new address information:\n${_selectedAddress.district} / ${_selectedAddress.province}",
      okText: "OK",
      okOnPressed: () {},
    );
    await showDialog(
      context: context,
      builder: (context) => alertDiaolog,
    );

    Navigator.pop(context);
  }
}
