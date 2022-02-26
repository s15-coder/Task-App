import 'package:flutter/material.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/helpers/validations.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/services/auth_service.dart';
import 'package:task_app/src/widgets/container_fields_auth.dart';
import 'package:task_app/src/widgets/custom_text_field.dart';
import 'package:task_app/src/widgets/painters/login_painter.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = "RegisterPage";
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
                painter: LoginPainter(),
                child: const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                right: 0,
                top: size.height * 0.15,
                child: const LoginLabel(),
              ),
              FormRegister()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginLabel extends StatelessWidget {
  const LoginLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, LoginPage.routeName),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(-2, 0)),
          ],
        ),
        child: const Text(
          'Login',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 24,
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class FormRegister extends StatelessWidget {
  FormRegister({Key? key}) : super(key: key);

  final ctrlEmail = TextEditingController();
  final ctrlName = TextEditingController();
  final ctrlPassword = TextEditingController();
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
              CustomTextField(
                hintText: 'Name',
                controller: ctrlName,
                prefixIcon: Icons.person_pin_circle_outlined,
                keyboardType: TextInputType.name,
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              CustomTextField(
                hintText: 'Email',
                controller: ctrlEmail,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              CustomTextField(
                obscureText: true,
                hintText: 'Password',
                controller: ctrlPassword,
                prefixIcon: Icons.lock,
              ),
            ],
            onSubmit: () => onSubmitRegister(context),
            submitIconData: Icons.arrow_forward,
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
    String? errorText = Validations().validateFields([
      Field(typeField: TypeField.email, value: email),
      Field(typeField: TypeField.name, value: name),
      Field(typeField: TypeField.password, value: password),
    ]);
    if (errorText != null) {
      return showMessageAlert(
          context: context, title: 'Verify', message: errorText);
    }
    showLoadingAlert(context);
    await AuthService().register(email, password, name);
    Navigator.pop(context);
  }
}
