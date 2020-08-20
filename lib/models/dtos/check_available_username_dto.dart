import 'dart:convert';

class CheckAvailableUsernameDTO {
  String username;

  CheckAvailableUsernameDTO({
    this.username,
  });

  Map<String, dynamic> toJson() => {
        "username": this.username,
      };
}

String checkAvailableUsernameToJson(CheckAvailableUsernameDTO data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
