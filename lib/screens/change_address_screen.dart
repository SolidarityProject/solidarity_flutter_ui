import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/address_fields.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

ThemeData _themeData;

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
      buttonText: "Change Address",
      buttonTextStyle: Styles.ADDRESS_BTN_TEXT,
      buttonColor: _themeData.accentColor,
      submitFunc: () => _submitTrueFunc(),
    );
  }

  void _submitTrueFunc() async {
    Address _selectedAddress = selectedAddressInfo;

    user = await changeUserAddress(_selectedAddress);

    futurePostList = getPostsByDistrictAddress(selectedAddressInfo.districtId);
    searchAddress = _selectedAddress;

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
