import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'package:my_frontend/global.dart';

import 'Board.dart';
import 'Menu.dart';
import 'models/Payload.dart';

class DrawApp extends StatelessWidget {
  const DrawApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final title = 'Ayaan Whiteboard';

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Payload> payloads = new List<Payload>();

  @override
  void initState() {
    super.initState();
    _listeners();
    _connectSocket01();
    Firestore.instance.settings(persistenceEnabled: false);
  }

  _listeners() {
    mxStore.socket.on('connect', (data) {
      print("connect");
    });
    mxStore.socket.on('connect_error', (data) => print(" faizal Error"));

    mxStore.socket.on('disconnect', (data) {
      print("faizal Disconnected");
    });

    mxStore.socket
        .on('reconnect_failed', (data) => print("faizal reconnect_failed"));
    mxStore.socket
        .on('reconnect_error', (data) => print("faizal reconnect_error"));
    mxStore.socket.on('reconnecting', (data) => print("faizal reconnecting"));

    mxStore.socket.on('broadcast', (data) {
      mxStore.addPayload(Payload.fromJson(data));
    });

    mxStore.socket.on('mouseup', (_) {
      print("mouse up ${mxStore.socket.id}");
      Payload payload = Payload(
          color: Colors.black,
          offset: null,
          strokeCap: StrokeCap.round,
          strokeWidth: 4.0);
      mxStore.addPayload(payload);
    });
    mxStore.socket.on('clear', (_) {
      mxStore.clear();
      print("clear ${mxStore.socket.id}");
    });
  }

  _connectSocket01() {
    mxStore.socket.connect();
    print("connect? ${mxStore.socket.connected}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onPanUpdate: (details) {
              RenderBox box = context.findRenderObject();
              Offset point = box.globalToLocal(details.globalPosition);

              Payload payload = Payload(
                  color: mxStore.color,
                  offset: point,
                  strokeCap: mxStore.strokeCap,
                  strokeWidth: mxStore.strokeWidth);

              mxStore.addPayload(payload);
              print(payload.toJson());
              mxStore.socket.emitWithAck('chat', payload.toJson(), ack: (data) {
                print('ack $data');
                if (data != null) {
                  print('from server $data');
                } else {
                  print("Null");
                }
              });

              //print(point);
            },
            onPanEnd: (details) {
              mxStore.socket.emit('mouseup', null);
              Payload payload = Payload(
                  color: Colors.black,
                  offset: null,
                  strokeCap: StrokeCap.round,
                  strokeWidth: 4.0);

              mxStore.addPayload(payload);
            },
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
                icon: Icon(Icons.colorize),
                onPressed: () {},
                color: mxStore.color,
              ),
            ),
          )
        ],
      ),
      floatingActionButton:
          MenuDrawing(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> fetchTitle() async {
    final response = await http.get(
        Uri.encodeFull('https://draw-backend.herokuapp.com/title'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var v = json.decode(response.body);
      return v['title'];
    } else {
      throw Exception('Failed to load post');
    }
  }
}
