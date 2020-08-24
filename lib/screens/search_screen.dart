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

String _provinceHintText;
String _districtHintText;

bool _submitStatus;

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
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
      _dropDownProvince(),
      _dropDownDistrict(),
      _submitButton(),
    ]);
  }

  Widget _futureBuilderCountryList() => FutureBuilder<List<Country>>(
        future: futureCountryList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            countries = snapshot.data;
            return _dropDownCountry();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );

  Widget _dropDownCountry() => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Country", style: Styles.TF_LABEL),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              decoration: Styles.TF_BOXDEC.copyWith(
                border: Border.all(color: Theme.of(context).accentColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Country>(
                  isExpanded: true,
                  hint: Text(
                    "Please select country",
                    style: Styles.TF_HINT.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  value: selectedCountry,
                  onChanged: (value) async {
                    setState(() {
                      selectedCountry = value;
                      _provinceHintText = "loading...";
                      _districtHintText = "Please select province first";
                      _submitStatus = false;
                    });
                    provinces = null;
                    selectedProvince = null;
                    districts = null;
                    selectedDistrict = null;

                    var newProvinces =
                        await getProvincesByCountryId(selectedCountry.id);
                    setState(() {
                      provinces = newProvinces;
                      _provinceHintText = "Please select province";
                    });
                  },
                  items: countries.map((country) {
                    return DropdownMenuItem<Country>(
                        value: country, child: Text(country.name));
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _dropDownProvince() => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Province", style: Styles.TF_LABEL),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              decoration: Styles.TF_BOXDEC.copyWith(
                border: Border.all(color: Theme.of(context).accentColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Province>(
                    isExpanded: true,
                    hint: Text(
                      _provinceHintText,
                      style: Styles.TF_HINT.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    value: selectedProvince,
                    onChanged: (value) async {
                      setState(() {
                        selectedProvince = value;
                        _districtHintText = "loading...";
                        _submitStatus = false;
                      });
                      districts = null;
                      selectedDistrict = null;

                      var newDistricts =
                          await getDistrictsByProvinceId(selectedProvince.id);

                      setState(() {
                        districts = newDistricts;
                        _districtHintText = "Please select district";
                      });
                    },
                    items: provinces != null
                        ? provinces.map((province) {
                            return DropdownMenuItem<Province>(
                                value: province, child: Text(province.name));
                          }).toList()
                        : null),
              ),
            ),
          ],
        ),
      );

  Widget _dropDownDistrict() => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("District", style: Styles.TF_LABEL),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              decoration: Styles.TF_BOXDEC.copyWith(
                border: Border.all(color: Theme.of(context).accentColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<District>(
                    isExpanded: true,
                    hint: Text(
                      _districtHintText,
                      style: Styles.TF_HINT.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    value: selectedDistrict,
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                        _submitStatus = true;
                      });
                    },
                    items: districts != null
                        ? districts.map((district) {
                            return DropdownMenuItem<District>(
                                value: district, child: Text(district.name));
                          }).toList()
                        : null),
              ),
            ),
          ],
        ),
      );

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
