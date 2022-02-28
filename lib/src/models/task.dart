import 'package:task_app/src/models/task_type.dart';

class Task {
  Task({
    this.state,
    this.name = '',
    this.description = '',
    this.createdAt,
    this.updatedAt,
    this.id = '',
  });

  TaskType? state;
  String name;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String id;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        state: TaskType.fromString(json["state"]),
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "name": name,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}
