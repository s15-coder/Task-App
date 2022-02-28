// To parse this JSON data, do
//
//     final genericResponse = genericResponseFromJson(jsonString);

import 'dart:convert';

GenericResponse genericResponseFromJson(String str) =>
    GenericResponse.fromJson(json.decode(str));

String genericResponseToJson(GenericResponse data) =>
    json.encode(data.toJson());

class GenericResponse {
  GenericResponse({
    required this.ok,
    this.msg = '',
  });

  bool ok;
  String msg;

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      GenericResponse(
        ok: json["ok"],
        msg: json["msg"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
      };
}
