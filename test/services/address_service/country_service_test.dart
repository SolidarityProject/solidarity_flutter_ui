import 'package:flutter_test/flutter_test.dart';
import 'package:solidarity_flutter_ui/services/address_service/country_service.dart';

void main() async {
  group("Address Service - Country Service Test Functions", () {
    test("GET : getAllCountry", () async {
      var result = await getAllCountry();
      expect(result[0].id, "5eef52787e2213196405352e");
      expect(result[1].id, "5f424b666c32aa27e8d7bb21");
    });

    test("GET : getCountryById", () async {
      var result = await getCountryById("5eef52787e2213196405352e");
      expect(result.id, "5eef52787e2213196405352e");
      expect(result.name, "Türkiye");
    });
  });
}
