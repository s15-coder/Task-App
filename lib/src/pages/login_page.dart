import 'package:flutter/material.dart';
import 'package:task_app/src/bloc/user_bloc.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/helpers/network_validator.dart';
import 'package:task_app/src/helpers/validations_fields.dart';
import 'package:task_app/src/pages/home_page.dart';
import 'package:task_app/src/pages/register_page.dart';
import 'package:task_app/src/widgets/container_fields_auth.dart';
import 'package:task_app/src/widgets/auth_text_field.dart';
import 'package:task_app/src/widgets/left_banner.dart';
import 'package:task_app/src/widgets/painters/login_painter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String routeName = "LoginPage";

  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  final focusPassword = FocusNode();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              CustomPaint(
                painter: LoginPainter(context),
                child: const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                left: 0,
                bottom: size.height * 0.15,
                child: LeftBanner(
                  label: 'Regiser',
                  onTap: () => Navigator.pushReplacementNamed(
                      context, RegisterPage.routeName),
                ),
              ),
              FormLogin(
                ctrlEmail: ctrlEmail,
                ctrlPassword: ctrlPassword,
                focusPassword: focusPassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
    required this.ctrlEmail,
    required this.ctrlPassword,
    required this.focusPassword,
  }) : super(key: key);

  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;
  final FocusNode focusPassword;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * .08),
          ContainerFieldsAuth(
            fields: [
              AuthTextField(
                hintText: 'Email',
                controller: ctrlEmail,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (_) => focusPassword.requestFocus(),
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              AuthTextField(
                obscureText: true,
                controller: ctrlPassword,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                focusNode: focusPassword,
                onSubmitted: (_) => onSubmitLogin(context),
              ),
            ],
            onSubmit: () => onSubmitLogin(context),
            submitIconData: Icons.arrow_forward,
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(right: size.width * .1),
            width: size.width,
            child: Text(
              'Forgot Password?',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 18, color: Colors.grey.withOpacity(1)),
            ),
          )
        ],
      ),
    );
  }

  onSubmitLogin(BuildContext context) async {
    String email = ctrlEmail.value.text;
    String password = ctrlPassword.value.text;
    //Validate fields
    String? errorText = ValidationsFields().validateFields([
      Field(typeField: TypeField.email, value: email, fieldName: 'email'),
      Field(
          typeField: TypeField.password,
          value: password,
          fieldName: 'password'),
    ]);
    if (errorText != null) {
      return showMessageAlert(
        context: context,
        title: 'Verify',
        message: errorText,
      );
    }
    if (!await NewtworkValidator.checkNetworkAndAlert(context)) return;

    showLoadingAlert(context);
    final response = await UserBloc().login(
      email: email,
      password: password,
    );
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
}
