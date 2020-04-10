import 'dart:ui';

import 'package:my_frontend/global.dart';

class Payload {
  final Offset offset;
  final Color color;
  final StrokeCap strokeCap;
  final double strokeWidth;

  Payload({this.strokeCap, this.strokeWidth, this.offset, this.color});

  dynamic toJson() {
    return {
      '_strokeCap': this.strokeCap,
      '_strokeWidth': this.strokeWidth,
      '_offset': this.offset.toJson(),
      '_color': this.color
    };
  }
}
