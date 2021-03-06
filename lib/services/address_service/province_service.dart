import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/province_model.dart';

final _apiUrl = "https://address-microservicee.herokuapp.com/api/v1/provinces";

Future<Province> getProvinceById(String provinceId) async {
  final response = await http.get(
    "$_apiUrl/$provinceId",
  );

  if (response.statusCode == 200) {
    return provinceFromJson(response.body);
  } else {
    return null;
  }
}

Future<List<Province>> getProvincesByCountryId(String countryId) async {
  final response = await http.get(
    "$_apiUrl/c/$countryId",
  );

  if (response.statusCode == 200) {
    return provinceListFromJson(response.body);
  } else {
    return null;
  }
}
