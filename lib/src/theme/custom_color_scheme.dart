import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get colorTaskCard => brightness == Brightness.light
      ? Colors.white
      : const Color.fromRGBO(96, 96, 96, 1);
}
