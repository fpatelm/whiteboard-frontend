import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
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
  TextEditingController _controller = TextEditingController();
  List<String> _myList = new List<String>();
  @override
  Widget build(BuildContext context) {
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
                      _myList.add(snapshot.data['info']);
                      return Expanded(
                        child: ListView.builder(
                            itemCount: _myList.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Text(_myList[index]);
                            }),
                      );
                  }
                })
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
      try {
        Firestore.instance
            .collection('messages')
            .document('payload')
            .updateData({'info': _controller.text});
        _controller.text = "";
      } catch (e) {
        print(e.toString());
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
}
