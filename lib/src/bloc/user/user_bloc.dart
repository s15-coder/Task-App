import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/models/responses/generic_response.dart';
import 'package:task_app/src/models/responses/login_response.dart';
import 'package:task_app/src/pages/home_page.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/resources/db_hive.dart';
import 'package:task_app/src/resources/preferences.dart';
import 'package:task_app/src/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(logged: isLogged())) {
    on<UserLogged>((event, emit) => emit(state.copyWith(logged: true)));
  }

  Future login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    showLoadingAlert(context);

    final response = await AuthService()
        .login(
          email: email,
          password: password,
        )
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () async => LoginResponse(
            ok: false,
            msg: 'Check your network connection',
          ),
        );
    if (response.ok) {
      await HiveDB().setUser(response.user!);
      await PreferencesApp().setToken(response.token!);
    }
    Navigator.pop(context);
    if (!response.ok) {
      return showMessageAlert(
        context: context,
        title: 'Failure',
        message: response.msg,
      );
    } else {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }

  Future register({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    showLoadingAlert(context);

    final response = await AuthService()
        .register(email: email, password: password, name: name)
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () async => GenericResponse(
            ok: false,
            msg: 'Check your network connection',
          ),
        );

    Navigator.pop(context);
    if (!response.ok) {
      switch (response.msg) {
        case "Someone is already using it email":
          return showMessageAlert(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: AppLocalizations.of(context)!.email_already_registered,
          );
        default:
          return showMessageAlert(
            context: context,
            title: 'Failure',
            message: response.msg,
          );
      }
    } else {
      return showMessageAlert(
          closeOnBackArrow: false,
          context: context,
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.successfully_registered,
          onOk: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginPage.routeName,
              (route) => false,
            );
          });
    }
  }

  static bool isLogged() => HiveDB().getUser() != null;
  Future logOut(TaskBloc taskBloc, BuildContext context) async {
    taskBloc.clearBloc();
    await Future.wait([
      HiveDB().deleteUser(),
      PreferencesApp().removeToken(),
    ]);

    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (route) => false,
    );
  }
}
