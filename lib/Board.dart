import 'package:flutter/material.dart';

import 'Sketcher.dart';
import 'models/Payload.dart';

class Board extends StatelessWidget {
  final List<Payload> payloads;

  Board({Key key, this.payloads}) : super(key: key);
  @override
  Container build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: CustomPaint(
        painter: Sketcher(payloads),
      ),
    );
  }
}
