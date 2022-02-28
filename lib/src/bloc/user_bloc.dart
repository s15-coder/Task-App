import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/models/responses/generic_response.dart';
import 'package:task_app/src/models/responses/login_response.dart';
import 'package:task_app/src/resources/db_hive.dart';
import 'package:task_app/src/resources/preferences.dart';
import 'package:task_app/src/services/auth_service.dart';

class UserBloc {
  static final UserBloc _instance = UserBloc._privateConstructor();
  factory UserBloc() => _instance;
  UserBloc._privateConstructor();

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
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
    return response;
  }

  Future<GenericResponse> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await AuthService()
        .register(email: email, password: password, name: name)
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () async => GenericResponse(
            ok: false,
            msg: 'Check your network connection',
          ),
        );

    return response;
  }

  bool isLogged() => HiveDB().getUser() != null;
  Future logOut(TaskBloc taskBloc) async {
    taskBloc.clearBloc();
    await Future.wait([
      HiveDB().deleteUser(),
      PreferencesApp().removeToken(),
    ]);
  }
}
