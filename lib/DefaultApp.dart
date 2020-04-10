import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DefaultApp extends StatelessWidget {
  const DefaultApp({Key key}) : super(key: key);
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
  TextEditingController _controller = TextEditingController();
  IO.Socket socket = IO.io('http://localhost:8080', <String, dynamic>{
    'transports': ['websocket'] // optional
  });
  List<String> _myList = new List<String>();

  @override
  void initState() {
    super.initState();
    _listeners();
  }

  _listeners() {
    socket.on('connect', (data) {
      print("connect");
    });
    socket.on('connect_error', (data) => print(" faizal Error"));

    socket.on('disconnect', (data) {
      print("faizal Disconnected");
    });

    socket.on('reconnect_failed', (data) => print("faizal reconnect_failed"));
    socket.on('reconnect_error', (data) => print("faizal reconnect_error"));
    socket.on('reconnecting', (data) => print("faizal reconnecting"));

    socket.on('chat', (data) {});
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Observer(
                builder: (_) => Text("mxStore.conectionState"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Connect"),
                    onPressed: () {
                      _connectSocket01();
                    },
                  ),
                  RaisedButton(
                    child: Text("Disconnect"),
                    onPressed: () {
                      _disconnectSocket();
                    },
                  ),
                ],
              ),
              Form(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Send a message'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      try {
        //socket.emit('chat', _controller.text);

        socket.emitWithAck('chat', _controller.text, ack: (data) {
          print('ack $data');
          if (data != null) {
            print('from server $data');
          } else {
            print("Null");
          }
        });

        _controller.text = "";
      } catch (e) {
        print('error:' + e.toString());
      }
    }
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

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  _onReceiveChatMessage(dynamic message) {
    print("Message from UFO: " + message);
  }

  void _disconnectSocket() {
    socket.disconnect();
  }
}
