import 'package:flutter/material.dart';

import 'Sketcher.dart';

class Board extends StatelessWidget {
  final List<Offset> points;
  Board({Key key, this.points}) : super(key: key);
  @override
  Container build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      color: Colors.blueGrey[50],
      child: CustomPaint(
        painter: Sketcher(points),
      ),
    );
  }
}
