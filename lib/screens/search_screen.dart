import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/address_fields.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

ThemeData _themeData;

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _buildAddressFields(),
      ),
    );
  }

  AddressFields _buildAddressFields() {
    return AddressFields(
      futureCountryList: futureCountryList,
      labelTextStyle: Styles.TF_LABEL,
      buttonText: "Show Result",
      buttonTextStyle: Styles.ADDRESS_BTN_TEXT,
      buttonColor: _themeData.accentColor,
      submitFunc: () => _submitTrueFunc(),
    );
  }

  void _submitTrueFunc() async {
    Address _selectedAddress = selectedAddressInfo;

    futurePostList = getPostsByDistrictAddress(selectedDistrict.id);
    searchAddress = _selectedAddress;

    var alertDiaolog = AlertDialogOneButton(
      title: "Success",
      content:
          "You can look the posts in ${_selectedAddress.district} / ${_selectedAddress.province}.",
      okText: "OK",
      okOnPressed: () {},
    );
    await showDialog(
      context: context,
      builder: (context) => alertDiaolog,
    );

    DefaultTabController.of(context).animateTo(0);
  }
}
