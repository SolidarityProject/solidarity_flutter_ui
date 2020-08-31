import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/screens/register_screen.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/address_fields.dart';
import 'package:solidarity_flutter_ui/widgets/color_container.dart';

class AddressSelectScreen extends StatefulWidget {
  @override
  _AddressSelectScreenState createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            ColorContainer(),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: _buildAddressFields(),
            ),
          ],
        ),
      ),
    );
  }

  AddressFields _buildAddressFields() {
    return AddressFields(
      futureCountryList: futureCountryListRegister,
      labelTextStyle: Styles.TF_LABEL_WHITE,
      buttonText: "Save Address",
      buttonTextStyle: Styles.LOGIN_BTN_TEXT,
      buttonColor: Colors.white,
      submitFunc: () => _submitTrueFunc(),
    );
  }

  void _submitTrueFunc() async {
    addressObj = selectedAddressInfo;
    addressController.text = addressObj.district + " / " + addressObj.province;

    Navigator.pop(context);
  }
}
