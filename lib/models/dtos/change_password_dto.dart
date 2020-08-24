import 'dart:convert';

class ChangePasswordDTO {
  String id;
  String oldPassword;
  String newPassword;

  ChangePasswordDTO({
    this.id,
    this.oldPassword,
    this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        "_id": this.id,
        "oldPassword": this.oldPassword,
        "newPassword": this.newPassword,
      };
}

String changePasswordToJson(ChangePasswordDTO data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
