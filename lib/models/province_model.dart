import 'dart:convert';

class Province {
  String id;
  String name;
  String countryId;

  Province({
    this.id,
    this.name,
    this.countryId,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json["_id"],
      name: json["name"],
      countryId: json["countryId"],
    );
  }
}

Province provinceFromJson(String str) {
  final jsonData = json.decode(str);
  return Province.fromJson(jsonData);
}

List<Province> provinceListFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Province>.from(jsonData.map((x) => Province.fromJson(x)));
}
