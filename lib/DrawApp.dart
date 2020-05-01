import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_frontend/global.dart';
import 'package:my_frontend/service/auth.dart';

import 'Board.dart';
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
  @override
  void initState() {
    super.initState();
    appService.init();
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      body: Stack(
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
          FutureBuilder(
            future: AuthService().signInAnon(),
            builder: (context, snapshot) {
              print(snapshot.connectionState.toString());
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Positioned(
                    top: 40,
                    right: 5,
                    child: IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: (snapshot.data as FirebaseUser)
                                .uid
                                .toString()));
                        key.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Copied to Clipboard"),
                          ),
                        );
                      },
                    ),
                  );
                case ConnectionState.waiting:
                  return Positioned(
                      top: 40, right: 5, child: CircularProgressIndicator());
                default:
                  return Text("");
              }
            },
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
