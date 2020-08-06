import 'dart:convert';

import 'package:solidarity_flutter_ui/models/user_model.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';

class StarredPost {
  String id;
  User user;
  Post post;

  StarredPost({
    this.id,
    this.user,
    this.post,
  });

  factory StarredPost.fromJson(Map<String, dynamic> json) {
    return StarredPost(
      id: json["_id"],
      user: User.fromJson(json["user"]),
      post: Post.fromJson(json["post"]),
    );
  }
}

StarredPost starredPostFromJson(String str) {
  final jsonData = json.decode(str);
  return StarredPost.fromJson(jsonData);
}
