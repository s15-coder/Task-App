import 'package:flutter/material.dart';

class LoginPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawFigureUp(canvas, size);
    final pen = Paint()..color = Colors.lightGreen;
    final path = Path();
    path.moveTo(size.width * 0.05, size.height);
    path.quadraticBezierTo(
      size.width * 0.06,
      size.height * .97,
      size.width * .34,
      size.height * .94,
    );
    path.quadraticBezierTo(
      size.width * .65,
      size.height * .93,
      size.width * .85,
      size.height * .8,
    );
    path.quadraticBezierTo(
      size.width,
      size.height * .7,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, pen);
  }

  void drawFigureUp(Canvas canvas, Size size) {
    //Draw figure up
    final pen = Paint();
    pen.color = Colors.lightGreen;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.35);
    path.quadraticBezierTo(
      size.width * 0.075,
      size.height * 0.35,
      size.width * 0.15,
      size.height * 0.25,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.09,
      size.width * 0.5,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.1,
      size.width,
      size.height * 0,
    );
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, pen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
