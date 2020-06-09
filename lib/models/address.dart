class Address {
  String country;
  String province;
  String district;

  Address({this.country, this.province, this.district});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json["country"],
      province: json["province"],
      district: json["district"],
    );
  }
}