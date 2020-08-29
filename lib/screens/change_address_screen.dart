import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/country_model.dart';
import 'package:solidarity_flutter_ui/models/district_model.dart';
import 'package:solidarity_flutter_ui/models/province_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/address_service/district_service.dart';
import 'package:solidarity_flutter_ui/services/address_service/province_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';
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

class ChangeAddressScreen extends StatefulWidget {
  @override
  _ChangeAddressScreenState createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Change Address",
          style: Styles.BLACK_TEXT,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _buildMainContainer(),
      ),
    );
  }

  Container _buildMainContainer() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        child: _buildAddressFieldsColumn(),
      ),
    );
  }

  Widget _buildAddressFieldsColumn() {
    return Column(
      children: [
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
        future: futureCountryList,
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
        labelTextStyle: Styles.TF_LABEL,
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
        labelTextStyle: Styles.TF_LABEL,
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
        labelTextStyle: Styles.TF_LABEL,
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
        child: FlatButton(
          color: Theme.of(context).accentColor,
          onPressed: _submitStatus
              ? () async => _submitTrueFunc()
              : () async => _submitFalseFunc(),
          child: Text(
            "Change Address",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      );

  void _submitTrueFunc() async {
    futurePostList = getPostsByFullAddress(selectedDistrict.id);
    var alertDiaolog = AlertDialogOneButton(
      title: "Success",
      content:
          "Changed your address.\nNew address information : ${selectedDistrict.name} / ${selectedProvince.name}",
      okText: "OK",
      okOnPressed: () {},
    );
    await showDialog(
      context: context,
      builder: (context) => alertDiaolog,
    );

    // TODO : change password operations

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
