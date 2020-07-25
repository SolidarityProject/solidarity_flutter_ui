import 'dart:convert';

class LoginDTO {
  String email;
  String password;

  LoginDTO({this.email, this.password});

  Map<String, dynamic> toJson() =>
      {"email": this.email, "password": this.password};
}

String loginToJson(LoginDTO data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
