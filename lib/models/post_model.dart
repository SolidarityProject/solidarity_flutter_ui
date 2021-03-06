import 'dart:convert';

import 'package:solidarity_flutter_ui/models/address_model.dart';

class Post {
  String id;
  String title;
  String description;
  String pictureUrl;
  Address address;
  String addressDetail;
  List<dynamic> starredUsers;
  bool activeStatus;
  DateTime dateSolidarity;
  DateTime dateCreated;
  String userId;

  Post(
      {this.id,
      this.activeStatus,
      this.address,
      this.addressDetail,
      this.dateCreated,
      this.dateSolidarity,
      this.description,
      this.pictureUrl,
      this.starredUsers,
      this.title,
      this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["_id"],
      activeStatus: json["activeStatus"],
      address: Address.fromJson(json["address"]),
      addressDetail: json["addressDetail"],
      dateCreated: DateTime.parse(json["dateCreated"]),
      dateSolidarity: DateTime.parse(json["dateSolidarity"]),
      description: json["description"],
      pictureUrl: json["pictureUrl"],
      starredUsers: json["starredUsers"],
      title: json["title"],
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
