import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/models/country_model.dart';
import 'package:solidarity_flutter_ui/models/district_model.dart';
import 'package:solidarity_flutter_ui/models/province_model.dart';
import 'package:solidarity_flutter_ui/screens/register_screen.dart';
import 'package:solidarity_flutter_ui/services/address_service/district_service.dart';
import 'package:solidarity_flutter_ui/services/address_service/province_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';
import 'package:solidarity_flutter_ui/widgets/color_container.dart';
import 'package:solidarity_flutter_ui/widgets/drop_down_field.dart';

ThemeData _themeData;

List<Country> countries;
Country selectedCountry;

List<Province> provinces;
Province selectedProvince;

List<District> districts;
District selectedDistrict;

String _countryHintText;
String _provinceHintText;
String _districtHintText;

bool _submitStatus;

class AddressSelectScreen extends StatefulWidget {
  @override
  _AddressSelectScreenState createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  @override
  void initState() {
    countries = null;
    selectedCountry = null;
    provinces = null;
    selectedProvince = null;
    districts = null;
    selectedDistrict = null;
    _submitStatus = false;

    _countryHintText = "loading...";
    _provinceHintText = "Please select country first";
    _districtHintText = "Please select country & province first";
    _submitStatus = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              ColorContainer(),
              _buildMainContainer(),
            ],
          )),
    );
  }

  Container _buildMainContainer() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: 60.0,
          bottom: 20.0,
          left: 30.0,
          right: 30.0,
        ),
        child: _buildAddressFieldsColumn(),
      ),
    );
  }

  Widget _buildAddressFieldsColumn() {
    return Column(
      children: [
        SizedBox(height: 20),
        _futureBuilderCountryList(),
        SizedBox(height: 20),
        _buildDropDownProvince(),
        SizedBox(height: 20),
        _buildDropDownDistrict(),
        SizedBox(height: 20),
        _submitButton(),
      ],
    );
  }

  Widget _futureBuilderCountryList() => FutureBuilder<List<Country>>(
        future: futureCountryListRegister,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            countries = snapshot.data;
            _countryHintText = "Please select country";
            return _buildDropDownCountry();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return _buildDropDownCountry();
          }
        },
      );

  Widget _buildDropDownCountry() => DropDownField(
        labelText: "Country",
        labelTextStyle: Styles.TF_LABEL_WHITE,
        fieldDecoration: Styles.TF_BOXDEC.copyWith(
          border: Border.all(
            color: _themeData.accentColor,
          ),
        ),
        hintText: _countryHintText,
        hintStyle: Styles.TF_HINT,
        icon: Icons.keyboard_arrow_down,
        items: countries,
        selectedValue: selectedCountry,
        themeColor: _themeData.accentColor,
        onChangedFunc: (_) => _dropDownCountryOnChanged(_),
        dropDownMenuItem: (_) => _dropDownMenuItemCountry(_),
      );

  Widget _buildDropDownProvince() => DropDownField(
        labelText: "Province",
        labelTextStyle: Styles.TF_LABEL_WHITE,
        fieldDecoration: Styles.TF_BOXDEC.copyWith(
          border: Border.all(
            color: _themeData.accentColor,
          ),
        ),
        hintText: _provinceHintText,
        hintStyle: Styles.TF_HINT,
        icon: Icons.keyboard_arrow_down,
        items: provinces,
        selectedValue: selectedProvince,
        themeColor: _themeData.accentColor,
        onChangedFunc: (_) => _dropDownProvinceOnChanged(_),
        dropDownMenuItem: (_) => _dropDownMenuItemProvince(_),
      );

  Widget _buildDropDownDistrict() => DropDownField(
        labelText: "District",
        labelTextStyle: Styles.TF_LABEL_WHITE,
        fieldDecoration: Styles.TF_BOXDEC.copyWith(
          border: Border.all(
            color: _themeData.accentColor,
          ),
        ),
        hintText: _districtHintText,
        hintStyle: Styles.TF_HINT,
        icon: Icons.keyboard_arrow_down,
        items: districts,
        selectedValue: selectedDistrict,
        themeColor: _themeData.accentColor,
        onChangedFunc: (_) => _dropDownDistrictOnChanged(_),
        dropDownMenuItem: (_) => _dropDownMenuItemDistrict(_),
      );

  void _dropDownCountryOnChanged(Country value) async {
    setState(() {
      selectedCountry = value;
      _provinceHintText = "loading...";
      _districtHintText = "Please select province first";

      provinces = null;
      selectedProvince = null;
      districts = null;
      selectedDistrict = null;
      _submitStatus = false;
    });

    var newProvinces = await getProvincesByCountryId(selectedCountry.id);
    setState(() {
      provinces = newProvinces;
      _provinceHintText = "Please select province";
    });
  }

  void _dropDownProvinceOnChanged(Province value) async {
    setState(() {
      selectedProvince = value;
      _districtHintText = "loading...";

      districts = null;
      selectedDistrict = null;
      _submitStatus = false;
    });

    var newDistricts = await getDistrictsByProvinceId(selectedProvince.id);

    setState(() {
      districts = newDistricts;
      _districtHintText = "Please select district";
    });
  }

  void _dropDownDistrictOnChanged(District value) {
    setState(() {
      selectedDistrict = value;
      _submitStatus = true;
    });
  }

  DropdownMenuItem<Country> _dropDownMenuItemCountry(Country item) {
    return DropdownMenuItem<Country>(
      value: item,
      child: Text(item.name),
    );
  }

  DropdownMenuItem<Province> _dropDownMenuItemProvince(Province item) {
    return DropdownMenuItem<Province>(
      value: item,
      child: Text(item.name),
    );
  }

  DropdownMenuItem<District> _dropDownMenuItemDistrict<T>(District item) {
    return DropdownMenuItem<District>(
      value: item,
      child: Text(item.name),
    );
  }

  Widget _submitButton() => Padding(
        padding: const EdgeInsets.all(25.0),
        child: RaisedButton(
          elevation: 5.0,
          padding: EdgeInsets.all(13.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            "Save Address",
            style: Styles.LOGIN_BTN_TEXT,
          ),
          onPressed: _submitStatus
              ? () async => _submitTrueFunc()
              : () async => _submitFalseFunc(),
        ),
      );

  void _submitTrueFunc() async {
    addressObj = Address(
      country: selectedCountry.name,
      countryId: selectedCountry.id,
      province: selectedProvince.name,
      provinceId: selectedProvince.id,
      district: selectedDistrict.name,
      districtId: selectedDistrict.id,
    );
    addressController.text =
        selectedDistrict.name + " / " + selectedProvince.name;

    countries = null;
    selectedCountry = null;
    provinces = null;
    selectedProvince = null;
    districts = null;
    selectedDistrict = null;
    _submitStatus = false;

    Navigator.pop(context);
  }

  void _submitFalseFunc() async {
    var alertDiaolog = AlertDialogOneButton(
      title: "OOPS!",
      content: "Please select all field first.",
      okText: "OK",
      okOnPressed: () {},
    );
    await showDialog(
      context: context,
      builder: (context) => alertDiaolog,
    );
  }
}
