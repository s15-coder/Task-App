import 'package:flutter/cupertino.dart';
import 'package:task_app/src/pages/home_page.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/pages/register_page.dart';

Map<String, Widget Function(BuildContext)> get routes => {
      HomePage.routeName: (_) => const HomePage(),
      RegisterPage.routeName: (_) => RegisterPage(),
      LoginPage.routeName: (_) => const LoginPage(),
    };
