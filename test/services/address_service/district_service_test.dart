import 'package:flutter_test/flutter_test.dart';
import 'package:solidarity_flutter_ui/services/address_service/district_service.dart';

void main() async {
  group("Address Service - District Service Test Functions", () {
    test("GET : getDistrictById", () async {
      var result = await getDistrictById("5eef567d7e2213196405353f");
      expect(result.id, "5eef567d7e2213196405353f");
      expect(result.name, "Ödemiş");
      expect(result.provinceId, "5eef530e7e22131964053531");
    });

    test("GET : getDistrictsByProvinceId", () async {
      var result = await getDistrictsByProvinceId("5eef530e7e22131964053531");
      expect(result[0].id, "5eef567d7e2213196405353c");
      expect(result[0].provinceId, "5eef530e7e22131964053531");
      expect(result[1].id, "5eef567d7e2213196405353d");
      expect(result[1].provinceId, "5eef530e7e22131964053531");
    });
  });
}
