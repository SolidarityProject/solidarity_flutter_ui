import 'dart:convert';

class Post {
  String id;
  String title;
  String description;
  bool activeStatus;
  String userId;

  Post({this.id, this.title, this.activeStatus, this.description, this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      activeStatus: json["activeStatus"],
      userId: json["userId"],
    );
  }
}

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

List<Post> postListFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
}
