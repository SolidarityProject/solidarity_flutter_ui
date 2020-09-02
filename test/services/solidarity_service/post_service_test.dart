import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await SharedPrefs.init();

  final _login = LoginDTO(
    email: "testuser_flutter@solidarity.org",
    password: "tU123123.",
  );
  await login(_login);

  final _postId = "5ef789fc398c473790a4e728";
  final _userId = "5ef7803367077a26d8b0f2db";
  final _userFullName = "Mustafa ÇEVİK";
  final _districtId = "5eef567d7e2213196405353f";
  final _district = "Ödemiş";
  final _provinceId = "5ed2c0e3bd08e22e84efea49";
  final _province = "İzmir";

  group("Solidarity Service - Post Service Test Functions", () {
    test("GET: getPostById", () async {
      var result = await getPostById(_postId);
      expect(result.id, _postId);
      expect(result.userId, _userId);
    });

    test("GET: getPostDetailById", () async {
      var result = await getPostDetailById(_postId);
      expect(result.post.id, _postId);
      expect(result.post.userId, _userId);
      expect(result.createdFullName, _userFullName);
    });

    test("GET: getPostsByUserId", () async {
      var result = await getPostsByUserId(_userId);
      expect(result[0].userId, _userId);
      expect(result[1].userId, _userId);
    });

    test("GET: getPostsByFullAddress", () async {
      var result = await getPostsByFullAddress(_districtId);
      expect(result[0].address.districtId, _districtId);
      expect(result[0].address.district, _district);
      expect(result[0].address.provinceId, _provinceId);
      expect(result[1].address.districtId, _districtId);
      expect(result[1].address.district, _district);
      expect(result[1].address.provinceId, _provinceId);
    });

    test("GET: getPostsByProvinceAddress", () async {
      var result = await getPostsByProvinceAddress(_provinceId);
      expect(result[0].address.provinceId, _provinceId);
      expect(result[0].address.province, _province);
      expect(result[1].address.provinceId, _provinceId);
      expect(result[1].address.province, _province);
    });
    test("GET: getPostsByProvinceAddressForFree", () async {
      var result = await getPostsByProvinceAddress(_provinceId);
      expect(result[0].address.provinceId, _provinceId);
      expect(result[0].address.province, _province);
      expect(result[1].address.provinceId, _provinceId);
      expect(result[1].address.province, _province);
    });
  });
}
