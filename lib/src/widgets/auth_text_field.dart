import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.onSubmitted,
  }) : super(key: key);
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      textCapitalization: textCapitalization,
      style: const TextStyle(fontSize: 19),
      controller: controller,
      obscureText: obscureText,
      autocorrect: false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
          right: 15,
        ),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          size: 30,
        ),
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
      ),
    );
  }
}
