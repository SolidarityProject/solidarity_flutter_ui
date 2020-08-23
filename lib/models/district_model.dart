import 'dart:convert';

class District {
  String id;
  String name;
  String provinceId;

  District({
    this.id,
    this.name,
    this.provinceId,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json["_id"],
      name: json["name"],
      provinceId: json["provinceId"],
    );
  }
}

District districtFromJson(String str) {
  final jsonData = json.decode(str);
  return District.fromJson(jsonData);
}

List<District> districtListFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<District>.from(jsonData.map((x) => District.fromJson(x)));
}
