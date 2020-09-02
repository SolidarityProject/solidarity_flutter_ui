import 'dart:convert';

import 'package:solidarity_flutter_ui/models/post_model.dart';

class PostDetailDTO {
  Post post;
  String createdFullName;
  String createdPictureUrl;

  PostDetailDTO({
    this.post,
    this.createdFullName,
    this.createdPictureUrl,
  });

  factory PostDetailDTO.fromJson(Map<String, dynamic> json) {
    return PostDetailDTO(
      post: Post.fromJson(json["post"]),
      createdFullName: json["createdFullName"],
      createdPictureUrl: json["createdPictureUrl"],
    );
  }
}

PostDetailDTO postDetailFromJson(String str) {
  final jsonData = json.decode(str);
  return PostDetailDTO.fromJson(jsonData);
}
