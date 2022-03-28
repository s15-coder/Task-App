import 'package:flutter/material.dart';

import 'dark_text_theme.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.lightGreen,
  textTheme: darkTextTheme,
  shadowColor: Colors.black87,
  iconTheme: const IconThemeData(
    color: Colors.green,
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.green,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.lightGreen,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.lightGreen,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith((states) => Colors.lightGreen),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: Colors.lightGreen),
  ),
);
