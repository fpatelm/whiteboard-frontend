import 'dart:convert';

import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/html.dart';

void main() {
  if (fb.apps.isEmpty) {
    fb.initializeApp(
        apiKey: "AIzaSyAQHRfP5PChm2s30kmxD1LJf42KcUZ372Y",
        appId: "1:863761083258:web:58e32e168ebe87978084c3",
        authDomain: "midyear-nebula-113706.firebaseapp.com",
        databaseURL: "https://midyear-nebula-113706.firebaseio.com",
        measurementId: "863761083258",
        projectId: "midyear-nebula-113706",
        storageBucket: "midyear-nebula-113706.appspot.com");
  }
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: title,
        channel:
            HtmlWebSocketChannel.connect(Uri.parse('ws://localhost:8080/name')),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final HtmlWebSocketChannel channel;

  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> _litems = new List<String>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                _litems.add(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
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
      widget.channel.sink.add({"name": _controller.text});
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
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
