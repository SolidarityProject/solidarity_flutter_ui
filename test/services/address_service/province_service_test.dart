import 'package:flutter_test/flutter_test.dart';
import 'package:solidarity_flutter_ui/services/address_service/province_service.dart';

void main() async {
  group("Address Service - Province Service Test Functions", () {
    test("GET : getProvinceById", () async {
      var result = await getProvinceById("5eef530e7e22131964053531");
      expect(result.id, "5eef530e7e22131964053531");
      expect(result.name, "İzmir");
      expect(result.countryId, "5eef52787e2213196405352e");
    });

    test("GET : getProvincesByCountryId", () async {
      var result = await getProvincesByCountryId("5eef52787e2213196405352e");
      expect(result[0].id, "5eef530e7e2213196405352f");
      expect(result[0].countryId, "5eef52787e2213196405352e");
      expect(result[1].id, "5eef530e7e22131964053530");
      expect(result[1].countryId, "5eef52787e2213196405352e");
    });
  });
}
