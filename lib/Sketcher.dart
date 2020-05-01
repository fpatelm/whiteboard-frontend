import 'package:flutter/material.dart';
import 'package:my_frontend/global.dart';
import 'package:my_frontend/models/Payload.dart';

class Sketcher extends CustomPainter {
  final List<Payload> payloads;
  List<Payload> _tempPayloads = new List<Payload>();
  final BuildContext context;
  Sketcher(this.payloads, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    print("looping: ${mxStore.artists.toString()}");
    mxStore.artists.forEach((it) {
      _tempPayloads.clear();
      _tempPayloads = payloads.where((element) {
        return element.uid == it.toString();
      }).toList();

      for (int i = 0; i < _tempPayloads.length - 1; i++) {
        if (_tempPayloads[i].offset != null &&
            _tempPayloads[i + 1].offset != null) {
          paint.color = _tempPayloads[i].color;
          paint.strokeWidth = _tempPayloads[i].strokeWidth;
          paint.strokeCap = _tempPayloads[i].strokeCap;
          canvas.drawLine(
              _tempPayloads[i].offset, _tempPayloads[i + 1].offset, paint);
        }
      }
    });

    /*  for (int i = 0; i < payloads.length - 1; i++) {
      if (payloads[i].offset != null && payloads[i + 1].offset != null) {
        //canvas.drawLine(convertOffset(payloads[i].offset),convertOffset(payloads[i + 1].offset), paint);
        canvas.drawLine(payloads[i].offset, payloads[i + 1].offset, paint);
        canvas.drawCircle(Offset(220, 200), 16, paint);
        canvas.drawLine(Offset(220, 200), Offset(320, 300), paint);
      }
    }*/
  }

  Offset convertOffset(Offset offset) {
    Size screenSize = MediaQuery.of(this.context).size;
    return Offset(offset.dx * screenSize.width, offset.dy * screenSize.height);
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.payloads != payloads;
  }
}
