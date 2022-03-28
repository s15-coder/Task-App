import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_app/src/resources/preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: PreferencesApp().getThemeMode())) {
    on<ChangeThemeEvent>(
        (event, emit) => emit(ThemeState(themeMode: event.themeMode)));
  }
  void toogleTheme(BuildContext context) async {
    late bool isDarkMode;
    late ThemeMode themeMode;

    final currentTheme = PreferencesApp().getThemeMode();
    if (currentTheme == ThemeMode.system) {
      var brightness = MediaQuery.of(context).platformBrightness;
      isDarkMode = brightness == Brightness.dark;
      themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    } else {
      themeMode =
          currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }
    await PreferencesApp().setThemeMode(themeMode);
    add(ChangeThemeEvent(themeMode));
  }
}
