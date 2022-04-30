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
    required this.tasks,
  });

  final bool ok;
  final String msg;
  final List<Task> tasks;

  SaveTaskResponse copyWith({
    bool? ok,
    String? msg,
    List<Task>? tasks,
  }) =>
      SaveTaskResponse(
        ok: ok ?? this.ok,
        msg: msg ?? this.msg,
        tasks: tasks ?? this.tasks,
      );

  factory SaveTaskResponse.fromJson(Map<String, dynamic> json) =>
      SaveTaskResponse(
        ok: json["ok"],
        msg: json["msg"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
      };
}
