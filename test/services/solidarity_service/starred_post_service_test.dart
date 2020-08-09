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

  final _login =
      LoginDTO(email: "semustafacevik@gmail.com", password: "c123123");
  await login(_login);

  final _starredPostId = "5f2d38629c97020017493bd0";
  final _postId = "5ef789fc398c473790a4e728";
  final _userId = "5ef7803367077a26d8b0f2db";

  final _newPostId = "5f19aa46d8bff6125c33b829";
  final _addStarredPostDTO = AddStarredPostDTO(
    postId: _newPostId,
  );
  group("Solidarity Service - Starred Post Service Test Functions", () {
    test("POST: addStarredPost", () async {
      var result = await addStarredPost(_addStarredPostDTO);
      expect(result, true);
    });

    test("GET: getStarredPostMyPosts", () async {
      var result = await getStarredPostMyPosts();
      expect(result, true);
    });

    test("GET: getStarredPostById", () async {
      var result = await getStarredPostById(_starredPostId);
      expect(result.user.id, _userId);
      expect(result.post.id, _postId);
    });

    test("GET: getStarredPostsByUserId", () async {
      var result = await getStarredPostsByUserId(_userId);
      expect(result[0].userId, _userId);
    });

    test("GET: getStarredPostUsersByPostId", () async {
      var result = await getStarredPostUsersByPostId(_postId);
      expect(result[0].id, _userId);
    });

    test("DEL: deleleStarredPost", () async {
      var result = await deleteStarredPost(_newPostId);
      expect(result, true);
    });
  });
}
