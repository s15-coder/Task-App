import 'package:flutter/material.dart';
import 'package:task_app/src/pages/register_page.dart';
import 'package:task_app/src/widgets/container_fields_auth.dart';
import 'package:task_app/src/widgets/custom_text_field.dart';
import 'package:task_app/src/widgets/painters/login_painter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = "LoginPage";
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
                left: 0,
                bottom: size.height * 0.15,
                child: const RegisterLabel(),
              ),
              const FormLogin()
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterLabel extends StatelessWidget {
  const RegisterLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushReplacementNamed(context, RegisterPage.routeName),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
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
          'Register',
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

class FormLogin extends StatelessWidget {
  const FormLogin({Key? key}) : super(key: key);

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
              const CustomTextField(
                hintText: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              const CustomTextField(
                obscureText: true,
                hintText: 'Password',
                prefixIcon: Icons.lock,
              ),
            ],
            onSubmit: () {},
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
}
