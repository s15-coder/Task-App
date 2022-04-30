import 'package:flutter/material.dart';
import 'package:task_app/src/theme/custom_color_scheme.dart';

class RightBanner extends StatelessWidget {
  const RightBanner(
      {Key? key,
      this.label,
      required this.onTap,
      this.prefixBanner,
      this.color})
      : super(key: key);
  final void Function()? onTap;
  final Color? color;
  final String? label;
  final Widget? prefixBanner;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // onTap: () => Navigator.pushReplacementNamed(context, LoginPage.routeName),
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
          color: color ?? Theme.of(context).colorScheme.colorTaskCard,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(-2, 0)),
          ],
        ),
        child: Row(
          children: [
            if (prefixBanner != null) prefixBanner!,
            if (label != null)
              Text(
                label!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
