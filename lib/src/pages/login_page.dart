import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/src/bloc/user/user_bloc.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/helpers/network_validator.dart';
import 'package:task_app/src/helpers/validations_fields.dart';
import 'package:task_app/src/pages/register_page.dart';
import 'package:task_app/src/widgets/container_fields_auth.dart';
import 'package:task_app/src/widgets/auth_text_field.dart';
import 'package:task_app/src/widgets/left_banner.dart';
import 'package:task_app/src/widgets/painters/login_painter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_app/src/widgets/right_banner.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String routeName = "LoginPage";

  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  final focusPassword = FocusNode();
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
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
                right: 0,
                top: size.height * 0.15,
                child: RightBanner(
                  color: Colors.red,
                  prefixBanner: const Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  onTap: () async =>
                      await userBloc.googleSignIn(context: context),
                ),
              ),
              Positioned(
                left: 0,
                bottom: size.height * 0.15,
                child: LeftBanner(
                  label: AppLocalizations.of(context)!.sign_up,
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    RegisterPage.routeName,
                  ),
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
          Text(
            AppLocalizations.of(context)!.sign_in,
            style: const TextStyle(
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
                hintText: AppLocalizations.of(context)!.password,
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
              AppLocalizations.of(context)!.forgot_password,
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
      Field(
        typeField: TypeField.email,
        value: email,
        fieldName: AppLocalizations.of(context)!.email,
      ),
      Field(
        typeField: TypeField.password,
        value: password,
        fieldName: AppLocalizations.of(context)!.password,
      ),
    ]);
    if (errorText != null) {
      return showMessageAlert(
        context: context,
        title: 'Versify',
        message: errorText,
      );
    }
    if (!await NewtworkValidator.checkNetworkAndAlert(context)) return;

    final userBloc = BlocProvider.of<UserBloc>(context);
    await userBloc.login(
      context: context,
      email: email,
      password: password,
    );
  }
}
