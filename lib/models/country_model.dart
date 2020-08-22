import 'dart:convert';

class Country {
  String id;
  String name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["_id"],
      name: json["name"],
    );
  }
}

Country countryFromJson(String str) {
  final jsonData = json.decode(str);
  return Country.fromJson(jsonData);
}

List<Country> countryListFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Country>.from(jsonData.map((x) => Country.fromJson(x)));
}
