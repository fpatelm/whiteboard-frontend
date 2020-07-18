import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'Board.dart';
import 'global.dart';

class draw_board extends StatelessWidget {
  const draw_board({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Stack(
      children: <Widget>[
        GestureDetector(
          onPanUpdate: (details) => appService.onDrawing(context, details),
          onPanEnd: (details) => appService.onStopDrawing(),
          onTapDown: (details) => appService.onDrawPoint(context, details),
          child: Observer(
            builder: (_) => Board(
              payloads: mxStore.payloads,
            ).build(context),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Observer(
            builder: (_) => IconButton(
              icon: Icon(
                  mxStore.brushMode ? MdiIcons.eraserVariant : Icons.brush),
              onPressed: () {},
              color: mxStore.brushMode ? Colors.black : mxStore.color,
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 5,
          child: IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: mxStore.userid.toString()));
              key.currentState.showSnackBar(
                SnackBar(
                  content: Text("Copied to Clipboard"),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
