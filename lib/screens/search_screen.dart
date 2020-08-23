import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/country_model.dart';
import 'package:solidarity_flutter_ui/models/province_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/address_service/province_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

List<Country> countries;
Country selectedCountry;

List<Province> provinces;
Province selectedProvince;

String _provinceHintText;

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    _provinceHintText = "Please select country first";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _futureBuilderCountryList(),
      _dropDownProvince(),
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
                    });
                    provinces = null;
                    selectedProvince = null;
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
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value;
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
}
