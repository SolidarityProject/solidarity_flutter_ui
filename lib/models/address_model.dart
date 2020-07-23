class Address {
  String country;
  String countryId;
  String province;
  String provinceId;
  String district;
  String districtId;

  Address(
      {this.country,
      this.countryId,
      this.province,
      this.provinceId,
      this.district,
      this.districtId});

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
}
