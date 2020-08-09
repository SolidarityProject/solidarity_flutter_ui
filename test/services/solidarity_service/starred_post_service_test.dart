import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarity_flutter_ui/models/dtos/add_starred_post_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/login_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/starred_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await SharedPrefs.init();

  final _login = LoginDTO(
    email: "user_starred264@test.com",
    password: "t123123",
  );
  await login(_login);

  final _postId = "5f19aa46d8bff6125c33b829";
  final _userId = "5f21618616d853050817326e";

  final _addStarredPostDTO = AddStarredPostDTO(
    postId: _postId,
  );
  group("Solidarity Service - Starred Post Service Test Functions", () {
    test("POST: addStarredPost", () async {
      var result = await addStarredPost(_addStarredPostDTO);
      expect(result, true);
    });

    test("GET: getMyStarredPosts", () async {
      var result = await getMyStarredPosts();
      expect(result, true);
    });

    test("GET: getStarredUsersByPostId", () async {
      var result = await getStarredUsersByPostId(_postId);
      expect(result[0], _userId);
    });

    test("GET: getStarredPostsByUserId", () async {
      var result = await getStarredPostsByUserId(_userId);
      expect(result[0].id, _postId);
    });
    test("GET: getStarredUsersInfoByPostId", () async {
      var result = await getStarredUsersInfoByPostId(_postId);
      expect(result[0].id, _userId);
    });

    test("DEL: deleleStarredPost", () async {
      var result = await deleteStarredPost(_postId);
      expect(result, true);
    });
  });
}
