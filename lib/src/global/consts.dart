import 'package:flutter/material.dart';
import 'package:task_app/src/models/task_type.dart';

enum Enviroment { development, production }
const Enviroment enviroment = Enviroment.production;
String get host => enviroment == Enviroment.development
    ? "http://10.0.2.2:3000"
    : "https://tasks-app-esteban.herokuapp.com";

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
