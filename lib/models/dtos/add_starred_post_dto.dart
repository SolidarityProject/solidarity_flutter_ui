import 'dart:convert';

class AddStarredPostDTO {
  String postId;

  AddStarredPostDTO({
    this.postId,
  });

  Map<String, dynamic> toJson() => {
        "postId": this.postId,
      };
}

String addStarredPostToJson(AddStarredPostDTO data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
