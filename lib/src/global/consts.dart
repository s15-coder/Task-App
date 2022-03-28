import 'package:flutter/material.dart';
import 'package:task_app/src/models/task_type.dart';

enum Enviroment { development, production }

const host = "http://10.0.2.2:3000";

const defaultTasksTypes = [
  TaskType(
    nameState: "To Do",
    colorState: Colors.red,
  ),
  TaskType(
    nameState: "Doing",
    colorState: Colors.blue,
  ),
  TaskType(
    nameState: "Done",
    colorState: Colors.lightGreen,
  ),
];
