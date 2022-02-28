// To parse this JSON data, do
//
//     final saveTaskResponse = saveTaskResponseFromJson(jsonString);

import 'dart:convert';

import 'package:task_app/src/models/task.dart';

SaveTaskResponse saveTaskResponseFromJson(String str) =>
    SaveTaskResponse.fromJson(json.decode(str));

String saveTaskResponseToJson(SaveTaskResponse data) =>
    json.encode(data.toJson());

class SaveTaskResponse {
  SaveTaskResponse({
    required this.ok,
    required this.msg,
    this.createdTask,
  });

  bool ok;
  String msg;
  Task? createdTask;

  factory SaveTaskResponse.fromJson(Map<String, dynamic> json) =>
      SaveTaskResponse(
        ok: json["ok"],
        msg: json["msg"],
        createdTask: Task.fromJson(json["created_task"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "created_task": createdTask!.toJson(),
      };
}
