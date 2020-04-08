import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'package:my_frontend/global.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DrawApp extends StatelessWidget {
  const DrawApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final title = 'Cloud Firestore';
    Firestore.instance.settings(persistenceEnabled: false);
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
  IO.Socket socket = IO.io('http://localhost:8080', <String, dynamic>{
    'transports': ['websocket'] // optional
  });

  @override
  void initState() {
    super.initState();
    _listeners();
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

    socket.on('chat', (data) {
      print('here: ' + data.toString());
      mxStore.setText(data.toString());
      mxStore.setIndex(7);
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
    final Container board = Container(
      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      color: Colors.blueGrey[50],
      child: CustomPaint(
        painter: Sketcher(mxStore.points),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('messages')
                  .document('payload')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Err8or: ${snapshot.error}");
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    List incoming = snapshot.data['point'];
                    for (String cordinate in incoming.reversed.toList()) {
                      print(cordinate);
                      if (cordinate == "null") {
                        mxStore.addPoint(null);
                      } else {
                        mxStore.addPoints(
                            double.parse(cordinate.split(';').elementAt(0)),
                            double.parse(cordinate.split(';').elementAt(1)));
                      }
                    }

                    return Container();
                }
              }),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox box = context.findRenderObject();
                Offset point = box.globalToLocal(details.globalPosition);
                mxStore.addPoint(point);
                try {
                  mxStore
                      .addList("${point.dx.toString()};${point.dy.toString()}");

                  print(mxStore.storeList);
                  Firestore.instance
                      .collection('messages')
                      .document('payload')
                      .setData(mxStore.storeList);
                } catch (e) {
                  print(e.toString());
                }
                print(point);
              });
            },
            onPanEnd: (details) {
              mxStore.addList("null");
              mxStore.addPoint(null);
              Firestore.instance
                  .collection('messages')
                  .document('payload')
                  .setData(mxStore.storeList);
            },
            child: Observer(
              builder: (_) => board,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mxStore.clear();
          Firestore.instance
              .collection('messages')
              .document('payload')
              .delete();
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

class Sketcher extends CustomPainter {
  final List<Offset> points;

  Sketcher(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.points != points;
  }
}
