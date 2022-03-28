import 'package:flutter/material.dart';
import 'package:task_app/src/theme/custom_color_scheme.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.colorTaskCard,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 10,
              color: Theme.of(context).shadowColor,
            )
          ]),
      margin: EdgeInsets.only(
        right: size.width * 0.05,
        left: size.width * 0.05,
        top: 30,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.05,
      ),
      child: child,
    );
  }
}
