import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_frontend/global.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Board.dart';
import 'models/Payload.dart';

class DrawApp extends StatelessWidget {
  const DrawApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final title = 'Cloud Firestore';

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
  List<Offset> points = new List<Offset>();
  List<Payload> payloads = new List<Payload>();
  IO.Socket socket = IO.io(getUrl(), <String, dynamic>{
    'transports': ['websocket'] // optional
  });

  @override
  void initState() {
    super.initState();
    _listeners();
    _connectSocket01();
    Firestore.instance.settings(persistenceEnabled: false);
  }

  _listeners() {
    socket.on('connect', (data) {
      mxStore.setConnectionState("Online");
      print("connect");
    });
    socket.on('connect_error', (data) => print(" faizal Error"));

    socket.on('disconnect', (data) {
      mxStore.setConnectionState("Offline");
      print("faizal Disconnected");
    });

    socket.on('reconnect_failed', (data) => print("faizal reconnect_failed"));
    socket.on('reconnect_error', (data) => print("faizal reconnect_error"));
    socket.on('reconnecting', (data) => print("faizal reconnecting"));

    socket.on('broadcast', (data) {
      print('from server here: ' + data.toString());
      setState(() {
        points = List.from(points)
          ..add(Offset(data['dx'] as double, data['dy'] as double));
      });
    });

    socket.on('mouseup', (_) {
      setState(() {
        points.add(null);
      });
    });
    socket.on('clear', (_) {
      setState(() {
        points.clear();
      });
    });
  }

  _connectSocket01() {
    try {
      socket.connect();
    } catch (e, s) {
      print(s.toString() + e.toString());
    }

    print("connect${socket.connected}");
  }

  _onSocketInfo(dynamic data) {
    print("Socket info: " + data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox box = context.findRenderObject();
                Offset point = box.globalToLocal(details.globalPosition);

                points = List.from(points)..add(point);
                Payload payload = Payload(
                    color: Colors.black,
                    offset: point,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 4.0);

                payloads = List.from(payloads)..add(payload);
                var i = {'dx': 507.2890625, 'dy': 369.0};

                print(Offset(i['dx'] as double, i['dy'] as double).toString());

                socket.emit('message', payload.toJson());

                socket.emitWithAck('chat', point.toJson(), ack: (data) {
                  print('ack $data');
                  if (data != null) {
                    print('from server $data');
                  } else {
                    print("Null");
                  }
                });

                print(point);
              });
            },
            onPanEnd: (details) {
              setState(() {
                socket.emitWithAck('mouseup', null, ack: (data) {
                  print('ack $data');
                });
                points.add(null);
              });
            },
            child: Board(points: points).build(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
