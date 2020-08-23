import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/country_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

List<Country> countries;
Country selectedCountry;

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _futureBuilderCountryList(),
      ),
    );
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

  Widget _dropDownCountry() => Column(
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
                hint: Text("Please select your country"),
                value: selectedCountry,
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value;
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
      );
}
