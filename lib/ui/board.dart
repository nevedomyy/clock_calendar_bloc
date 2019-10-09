import 'package:flutter/material.dart';
import 'dart:math' as math;


class Board extends CustomPainter{

  _unit(Canvas canvas, String unit, double x, double y){
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 12.0),
        text: unit
    );
    TextPainter painter = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.rtl
    );
    painter.layout();
    painter.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    double w = size.width/2;
    canvas.drawCircle(Offset(w, w), w, Paint()..color = Colors.black);
    canvas.drawCircle(Offset(w, w), 3.0, paint);
    w -= 5;
    for(int i=0; i<60; i++) canvas.drawLine(Offset(w+5+w*math.sin(i*6*math.pi/180), w+5+w*math.cos(i*6*math.pi/180)),
        Offset(w+5+(w-(i%5==0?7:3))*math.sin(i*6*math.pi/180), w+5+(w-(i%5==0?7:3))*math.cos(i*6*math.pi/180)), paint);
    for(int i=0; i<12; i++) _unit(canvas, (i==0?12:i).toString(), w+5-3+(w-16)*math.sin((90-i)*30*math.pi/180), w+5-6+(w-16)*math.cos((90-i)*30*math.pi/180));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}