import 'package:flutter/material.dart';

import 'light_text_theme.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  textTheme: lightTextTheme,
  textButtonTheme:
      TextButtonThemeData(style: TextButton.styleFrom(primary: Colors.black)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.green),
    ),
  ),
  canvasColor: Colors.grey[200],
  shadowColor: Colors.grey[200],
  backgroundColor: const Color(0xffecf3f3),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.green,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.green,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: Colors.black),
  ),
);
