import 'package:flutter/material.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: LoginPage.routeName,
      theme: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.green,
              secondary: Colors.green,
            ),
      ),
    );
  }
}
