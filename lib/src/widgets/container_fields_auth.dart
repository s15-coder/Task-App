import 'package:flutter/material.dart';
import 'package:task_app/src/theme/custom_color_scheme.dart';

class ContainerFieldsAuth extends StatelessWidget {
  const ContainerFieldsAuth({
    Key? key,
    required this.fields,
    required this.submitIconData,
    required this.onSubmit,
  }) : super(key: key);
  final List<Widget> fields;
  final VoidCallback onSubmit;
  final IconData submitIconData;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: size.width * 0.2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        color: Theme.of(context).colorScheme.colorTaskCard,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: fields,
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Transform.translate(
              offset: const Offset(25, 0),
              child: GestureDetector(
                onTap: onSubmit,
                child: CircleAvatar(
                  maxRadius: 30,
                  child: Icon(
                    submitIconData,
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
