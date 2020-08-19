import 'dart:convert';

class CheckAvailableEmailDTO {
  String email;

  CheckAvailableEmailDTO({
    this.email,
  });

  Map<String, dynamic> toJson() => {
        "email": this.email,
      };
}

String checkAvailableEmailToJson(CheckAvailableEmailDTO data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
