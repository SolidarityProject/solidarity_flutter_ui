import 'dart:convert';

class Login {
  String email;
  String password;

  Login({this.email, this.password});

  Map<String, dynamic> toJson() =>
      {"email": this.email, "password": this.password};
}

String loginToJson(Login data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
