import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_frontend/draw_board.dart';
import 'package:my_frontend/global.dart';
import 'package:my_frontend/service/app.dart';
import 'package:my_frontend/service/auth.dart';

import 'Menu.dart';

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
  Future<FirebaseUser> userFuture;
  @override
  void initState() {
    super.initState();
    userFuture = _getUser();
    userFuture.then((value) => appService.init());
  }

  Future<FirebaseUser> _getUser() async {
    return await AuthService().signInAnon();
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<FirebaseUser>(
        future: userFuture,
        builder: (context, snapshot) {
          print(snapshot.connectionState.toString());
          if (snapshot.hasError) {
            return Center(
              child: Text("Error Connecting!"),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              BoardAppService().sendAndStoreUser(snapshot.data);
              print("faizal" + snapshot.data.uid);
              return draw_board();
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.none:
            default:
              return Text("");
          }
        },
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
