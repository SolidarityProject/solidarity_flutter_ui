import 'dart:convert';

import 'package:solidarity_flutter_ui/models/address_model.dart';

class Post {
  String id;
  String title;
  String description;
  String pictureUrl;
  Address address;
  String provinceAddress;
  String fullAddress;
  bool activeStatus;
  DateTime dateSolidarity;
  DateTime dateCreated;
  String userId;

  Post(
      {this.id,
      this.activeStatus,
      this.address,
      this.dateCreated,
      this.dateSolidarity,
      this.description,
      this.fullAddress,
      this.pictureUrl,
      this.provinceAddress,
      this.title,
      this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["_id"],
      activeStatus: json["activeStatus"],
      address: Address.fromJson(json["address"]),
      dateCreated: DateTime.parse(json["dateCreated"]),
      dateSolidarity: DateTime.parse(json["dateSolidarity"]),
      description: json["description"],
      fullAddress: json["fullAddress"],
      pictureUrl: json["pictureUrl"],
      provinceAddress: json["provinceAddress"],
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
