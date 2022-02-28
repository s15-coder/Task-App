// To parse this JSON data, do
//
//     final getTasksResponse = getTasksResponseFromJson(jsonString);

import 'dart:convert';

import 'package:task_app/src/models/task.dart';

GetTasksResponse getTasksResponseFromJson(String str) =>
    GetTasksResponse.fromJson(json.decode(str));

String getTasksResponseToJson(GetTasksResponse data) =>
    json.encode(data.toJson());

class GetTasksResponse {
  GetTasksResponse({
    required this.ok,
    required this.tasks,
  });

  bool ok;
  List<Task> tasks;

  factory GetTasksResponse.fromJson(Map<String, dynamic> json) =>
      GetTasksResponse(
        ok: json["ok"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
      };
}
