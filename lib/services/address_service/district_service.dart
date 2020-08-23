import 'package:http/http.dart' as http;
import 'package:solidarity_flutter_ui/models/district_model.dart';

final _apiUrl = "https://address-microservicee.herokuapp.com/districts";

Future<District> getDistrictById(String districtId) async {
  final response = await http.get(
    "$_apiUrl/getbyid/$districtId",
  );

  if (response.statusCode == 200) {
    return districtFromJson(response.body);
  } else {
    return null;
  }
}

Future<List<District>> getDistrictsByProvinceId(String provinceId) async {
  final response = await http.get(
    "$_apiUrl/getbyprovinceid/$provinceId",
  );

  if (response.statusCode == 200) {
    return districtListFromJson(response.body);
  } else {
    return null;
  }
}
