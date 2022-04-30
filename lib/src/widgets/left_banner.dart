import 'package:flutter/material.dart';
import 'package:task_app/src/theme/custom_color_scheme.dart';

class LeftBanner extends StatelessWidget {
  const LeftBanner({
    Key? key,
    this.label,
    required this.onTap,
    this.prefixBanner,
    this.color,
  }) : super(key: key);
  final String? label;
  final Widget? prefixBanner;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          color: color ?? Theme.of(context).colorScheme.colorTaskCard,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(-2, 0),
            ),
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
              )
          ],
        ),
      ),
    );
  }
}
