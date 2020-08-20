import 'dart:convert';

class Address {
  String country;
  String countryId;
  String province;
  String provinceId;
  String district;
  String districtId;

  Address({
    this.country,
    this.countryId,
    this.province,
    this.provinceId,
    this.district,
    this.districtId,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json["country"],
      countryId: json["countryId"],
      province: json["province"],
      provinceId: json["provinceId"],
      district: json["district"],
      districtId: json["districtId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "country": this.country,
        "countryId": this.countryId,
        "province": this.province,
        "provinceId": this.provinceId,
        "district": this.district,
        "districtId": this.districtId,
      };
}

Address addressFromJson(String str) {
  final jsonData = json.decode(str);
  return Address.fromJson(jsonData);
}

String addressToJson(Address data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
