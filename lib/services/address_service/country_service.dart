import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/country_model.dart';

final _apiUrl = "https://address-microservicee.herokuapp.com/countries";

Future<List<Country>> getAllCountry() async {
  final response = await http.get(
    "$_apiUrl/getall",
  );

  if (response.statusCode == 200) {
    return countryListFromJson(response.body);
  } else {
    return null;
  }
}

Future<Country> getCountryById(String countryId) async {
  final response = await http.get(
    "$_apiUrl/getbyid/$countryId",
  );

  if (response.statusCode == 200) {
    return countryFromJson(response.body);
  } else {
    return null;
  }
}
