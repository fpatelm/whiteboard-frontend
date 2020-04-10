import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_frontend/global.dart';

class Payload {
  final Offset offset;
  final Color color;
  final StrokeCap strokeCap;
  final double strokeWidth;
  //{_strokeCap: {_strokeCap: StrokeCap.round}, _strokeWidth: 4, _offset: {dx: 475.7890625, dy: 355.6953125}, _color: {r: 0, g: 0, b: 0}}
  Payload({this.strokeCap, this.strokeWidth, this.offset, this.color});
  dynamic toJson() {
    return {
      '_strokeCap': this.strokeCap.toJson(),
      '_strokeWidth': this.strokeWidth,
      '_offset': this.offset.toJson(),
      '_color': this.color.toJson()
    };
  }

  Payload.fromJson(Map<String, dynamic> json)
      : offset = Offset(double.parse(json['_offset']['dx'].toString()),
            double.parse(json['_offset']['dy'].toString())),
        color = Color.fromRGBO(json['_color']['r'] as int,
            json['_color']['g'] as int, json['_color']['b'] as int, 1),
        strokeCap = json['_strokeCap'] == 'StrokeCap.round'
            ? StrokeCap.round
            : StrokeCap.butt,
        strokeWidth = double.parse(json['_strokeWidth'].toString());
}
