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

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

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

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    _countryHintText = "loading...";
    _provinceHintText = "Please select country first";
    _districtHintText = "Please select country & province first";
    _submitStatus = false;
    super.initState();
  }

  //TODO : refactoring -> search_screen

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _futureBuilderCountryList(),
      _buildDropDownProvince(),
      _buildDropDownDistrict(),
      _submitButton(),
    ]);
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

  Widget _buildDropDownCountry() => _buildDropDown(
        "Country",
        _countryHintText,
        selectedCountry,
        countries,
        (T) => _dropDownCountryOnChanged(T),
        _dropDownMenuItemCountry,
      );

  Widget _buildDropDownProvince() => _buildDropDown(
        "Province",
        _provinceHintText,
        selectedProvince,
        provinces,
        (T) => _dropDownProvinceOnChanged(T),
        _dropDownMenuItemProvince,
      );

  Widget _buildDropDownDistrict() => _buildDropDown(
        "District",
        _districtHintText,
        selectedDistrict,
        districts,
        (T) => _dropDownDistrictOnChanged(T),
        _dropDownMenuItemDistrict,
      );

  //* build drop down (generic)
  Widget _buildDropDown<T>(
    String labelText,
    String hintText,
    T selectedValue,
    List<T> items,
    void onChangedFunc(T),
    DropdownMenuItem<T> dropDownMenuItem(T),
  ) =>
      Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* drop down label
            Text(labelText, style: Styles.TF_LABEL),

            SizedBox(height: 10.0),

            //* drop down container (padding, decoration, child -> drop down button)
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              decoration: Styles.TF_BOXDEC.copyWith(
                border: Border.all(color: Theme.of(context).accentColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                    isExpanded: true,
                    hint: Text(
                      hintText,
                      style: Styles.TF_HINT.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    value: selectedValue,
                    onChanged: (value) {
                      onChangedFunc(value);
                    },
                    items: items != null
                        ? items.map((item) {
                            return dropDownMenuItem(item);
                          }).toList()
                        : null),
              ),
            ),
          ],
        ),
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

  DropdownMenuItem<T> _dropDownMenuItemCountry<T>(T item) {
    Country country = item as Country;
    return DropdownMenuItem<T>(
      value: item,
      child: Text(country.name),
    );
  }

  DropdownMenuItem<T> _dropDownMenuItemProvince<T>(T item) {
    Province province = item as Province;
    return DropdownMenuItem<T>(
      value: item,
      child: Text(province.name),
    );
  }

  DropdownMenuItem<T> _dropDownMenuItemDistrict<T>(T item) {
    District district = item as District;
    return DropdownMenuItem<T>(
      value: item,
      child: Text(district.name),
    );
  }

  Widget _submitButton() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: FlatButton(
          color: Theme.of(context).accentColor,
          onPressed: _submitStatus
              ? () async {
                  futurePostList = getPostsByFullAddress(selectedDistrict.id);
                  var alertDiaolog = AlertDialogOneButton(
                    title: "Success",
                    content:
                        "You can look the posts in ${selectedDistrict.name} / ${selectedProvince.name}.",
                    okText: "OK",
                    okOnPressed: () {},
                  );
                  await showDialog(
                    context: context,
                    builder: (context) => alertDiaolog,
                  );

                  DefaultTabController.of(context).animateTo(0);
                }
              : () async {
                  ///
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

                  ///
                },
          child: Text(
            "Show Result",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      );
}
