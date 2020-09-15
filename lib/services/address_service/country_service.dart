import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/country_model.dart';

final _apiUrl = "https://address-microservicee.herokuapp.com/api/v1/countries";

Future<List<Country>> getAllCountry() async {
  final response = await http.get(
    "$_apiUrl",
  );

  if (response.statusCode == 200) {
    return countryListFromJson(response.body);
  } else {
    return null;
  }
}

Future<Country> getCountryById(String countryId) async {
  final response = await http.get(
    "$_apiUrl/$countryId",
  );

  if (response.statusCode == 200) {
    return countryFromJson(response.body);
  } else {
    return null;
  }
}
