import 'package:flutter/material.dart';
import 'package:task_app/src/bloc/user_bloc.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/helpers/validations_fields.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/widgets/container_fields_auth.dart';
import 'package:task_app/src/widgets/auth_text_field.dart';
import 'package:task_app/src/widgets/painters/login_painter.dart';
import 'package:task_app/src/widgets/right_banner.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  static const String routeName = "RegisterPage";

  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  final ctrlName = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                  label: 'Login',
                  onTap: () => Navigator.pushReplacementNamed(
                      context, LoginPage.routeName),
                ),
              ),
              FormRegister(
                ctrlEmail: ctrlEmail,
                ctrlPassword: ctrlPassword,
                ctrlName: ctrlName,
                emailFocus: emailFocus,
                passwordFocus: passwordFocus,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormRegister extends StatelessWidget {
  const FormRegister({
    Key? key,
    required this.ctrlEmail,
    required this.ctrlPassword,
    required this.ctrlName,
    required this.emailFocus,
    required this.passwordFocus,
  }) : super(key: key);

  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;
  final TextEditingController ctrlName;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
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
            'Register',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          ContainerFieldsAuth(
            fields: [
              AuthTextField(
                hintText: 'Name',
                textCapitalization: TextCapitalization.words,
                controller: ctrlName,
                prefixIcon: Icons.person_pin_circle_outlined,
                keyboardType: TextInputType.name,
                onSubmitted: (value) {
                  emailFocus.requestFocus();
                },
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              AuthTextField(
                hintText: 'Email',
                textCapitalization: TextCapitalization.sentences,
                controller: ctrlEmail,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocus,
                onSubmitted: (value) {
                  passwordFocus.requestFocus();
                },
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              AuthTextField(
                obscureText: true,
                hintText: 'Password',
                controller: ctrlPassword,
                prefixIcon: Icons.lock,
                focusNode: passwordFocus,
                onSubmitted: (value) => onSubmitRegister(context),
              ),
            ],
            onSubmit: () => onSubmitRegister(context),
            submitIconData: Icons.check,
          )
        ],
      ),
    );
  }

  Future onSubmitRegister(BuildContext context) async {
    String name = ctrlName.value.text;
    String email = ctrlEmail.value.text;
    String password = ctrlPassword.value.text;
    //Validate fields
    String? errorText = ValidationsFields().validateFields([
      Field(typeField: TypeField.name, value: name, fieldName: 'name'),
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
    showLoadingAlert(context);
    final response = await UserBloc().register(
      email: email,
      password: password,
      name: name,
    );
    Navigator.pop(context);

    if (!response.ok) {
      return showMessageAlert(
        context: context,
        title: 'Failure',
        message: response.msg,
      );
    } else {
      return showMessageAlert(
          closeOnBackArrow: false,
          context: context,
          title: 'Success',
          message: "Successfully registered",
          onOk: () {
            //Close alert
            Navigator.pop(context);
            //Change page
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
          });
    }
  }
}
