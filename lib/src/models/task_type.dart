import 'package:flutter/material.dart';
import 'package:task_app/src/global/consts.dart';

class TaskType {
  final String nameState;
  final Color colorState;

  const TaskType({
    required this.nameState,
    required this.colorState,
  });
  factory TaskType.fromString(String? nameTask) => nameTask != null
      ? defaultTasksTypes.firstWhere(
          (taskState) => taskState.nameState == nameTask,
        )
      : defaultTasksTypes.first;
}
