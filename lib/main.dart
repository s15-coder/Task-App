import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/bloc/user_bloc.dart';
import 'package:task_app/src/pages/home_page.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/resources/db_hive.dart';
import 'package:task_app/src/resources/preferences.dart';
import 'package:task_app/src/routes/routes.dart';

void main() async {
  await HiveDB().init();
  await PreferencesApp().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute:
            UserBloc().isLogged() ? HomePage.routeName : LoginPage.routeName,
        theme: Theme.of(context).copyWith(
          scaffoldBackgroundColor: Colors.grey[100],
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.green,
                secondary: Colors.green,
              ),
        ),
      ),
    );
  }
}
