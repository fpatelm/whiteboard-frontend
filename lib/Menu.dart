import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_frontend/global.dart';
/*
FloatingActionButton buildFloatAction() {
  return FloatingActionButton(
    onPressed: () {
      setState(() {
        points.clear();
        socket.emitWithAck('clear', null, ack: (data) {
          print('ack clear');
        });
      });
    },
    tooltip: 'clear screen',
    child: Icon(Icons.refresh),
  );
}*/

class MenuDrawing extends StatelessWidget {
  MenuDrawing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _openDialog(String title, Widget content) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(6.0),
            title: Text(title),
            content: content,
            actions: [],
          );
        },
      );
    }

    void _openMainColorPicker() async {
      _openDialog(
        "Color picker",
        MaterialColorPicker(
            selectedColor: mxStore.color,
            allowShades: false,
            shrinkWrap: true,
            onMainColorChange: (color) {
              Navigator.of(context).pop();
              mxStore.setColor(color);
            }),
      );
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
            child: Icon(MdiIcons.refresh, color: Colors.white),
            backgroundColor: Colors.orange,
            onTap: () => appService.emitClearToOthers(),
            labelBackgroundColor: Colors.orange),
        SpeedDialChild(
          child: Icon(MdiIcons.eraserVariant, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => appService.selectEraser(),
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Observer(
            builder: (_) => Icon(Icons.brush,
                color: mxStore.brushMode ? mxStore.savedColor : mxStore.color),
          ),
          backgroundColor: Colors.white,
          onTap: () => appService.selectPencil(),
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Observer(
            builder: (_) => Icon(Icons.color_lens, color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          onTap: () {
            _openMainColorPicker();
            appService.selectColorPicker();
          },
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
      ],
    );
  }
}
