import 'package:flutter/material.dart';


class RedArrow extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    final paint = Paint()..color = Colors.red;
    canvas.drawLine(Offset(w/2, h*3/4-9+h/16), Offset(w/2, h), paint..strokeWidth = 2);
    path.moveTo(w/3, h*3/4-45);
    path.lineTo(w*2/3, h*3/4-45);
    path.lineTo(w*2/3, h*3/4-12+h/32);
    path.lineTo(w, h*3/4-12+h/32);
    path.lineTo(w/2, h*3/4-12+5+h/16);
    path.lineTo(0, h*3/4-12+h/32);
    path.lineTo(w/3, h*3/4-12+h/32);
    path.lineTo(w/3, h*3/4-45);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}