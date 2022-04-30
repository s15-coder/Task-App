import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/bloc/theme/theme_bloc.dart';
import 'package:task_app/src/bloc/user/user_bloc.dart';
import 'package:task_app/src/pages/home_page.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/resources/db_hive.dart';
import 'package:task_app/src/resources/preferences.dart';
import 'package:task_app/src/routes/routes.dart';
import 'package:task_app/src/theme/dark/dark_theme.dart';
import 'package:task_app/src/theme/light/light_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesApp().init();
  await HiveDB().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return _MyApp(themeMode: state.themeMode);
        },
      ),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key, required this.themeMode}) : super(key: key);
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute:
          HiveDB().getUser() != null ? HomePage.routeName : LoginPage.routeName,
      themeMode: themeMode,
      darkTheme: darkTheme,
      theme: lightTheme,
    );
  }
}
