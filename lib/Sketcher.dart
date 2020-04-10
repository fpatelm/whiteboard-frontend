import 'package:flutter/material.dart';
import 'package:my_frontend/models/Payload.dart';

class Sketcher extends CustomPainter {
  final List<Payload> payloads;

  Sketcher(this.payloads);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (int i = 0; i < payloads.length - 1; i++) {
      if (payloads[i].offset != null && payloads[i + 1].offset != null) {
        paint.color = payloads[i].color;
        paint.strokeCap = payloads[i].strokeCap;
        paint.strokeWidth = payloads[i].strokeWidth;
        canvas.drawLine(payloads[i].offset, payloads[i + 1].offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.payloads != payloads;
  }
}
