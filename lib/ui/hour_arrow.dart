import 'package:flutter/material.dart';


class HArrow extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(0, 0), Offset(0, size.height-40), Paint()..color = Colors.white..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}