import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_frontend/global.dart';
import 'package:my_frontend/models/Payload.dart';

import 'auth.dart';

class BoardAppService {
  void init() {
    socketService.init();
    socketService.handleConnect();
    print("connect? ${socketService.socket.connected}");

    authenticateUserAndStore();

    socketService.received(
        event: 'broadcast',
        callback: (data) => mxStore.addPayload(Payload.fromJson(data)));

    //server sends the shareID
    socketService.received(
        event: 'usersaved',
        callback: (data) {
          print('saved userid to database >> ${data.toString()}');
          mxStore.addArtists(data.toString());
        });

    socketService.received(
        event: 'mouseup',
        callback: (data) {
          Payload payload = Payload(
              color: Colors.black,
              offset: null,
              strokeCap: StrokeCap.round,
              strokeWidth: 4.0,
              uid: data.toString());
          mxStore.addPayload(payload);
        });

    socketService.received(event: 'clear', callback: (data) => mxStore.clear());
  }

  void authenticateUserAndStore() {
    Future<FirebaseUser> user = AuthService().signInAnon();
    user.then((value) {
      if (value != null) {
        socketService.socket.on('connect', (data) {
          print("Connect");
          //Send the userid to backend in order to save it in database
          socketService.emit(event: 'userid', data: value.uid);
          print("current user firebae: ${value.uid}");
        });
        mxStore.addArtists(value.uid.toString());
        mxStore.setUserId(value);
      }
      if (value != null) print(value.uid);
    });
  }

  void onDrawing(BuildContext context, dynamic details) {
    RenderBox box = context.findRenderObject();
    Offset point = box.globalToLocal(details.globalPosition);
    // Size screenSize = MediaQuery.of(context).size;
    Payload payload = Payload(
        color: mxStore.color,
        offset: point,
        strokeCap: mxStore.strokeCap,
        strokeWidth: mxStore.strokeWidth,
        uid: mxStore.userid.uid.toString());
    mxStore.addPayload(payload);
    socketService.emit(event: 'chat', data: payload.toJson());
  }

  onDrawPoint(BuildContext context, dynamic details) {
    RenderBox box = context.findRenderObject();
    Offset point = box.globalToLocal(details.globalPosition);
    // Size screenSize = MediaQuery.of(context).size;
    Payload payload = Payload(
        color: mxStore.color,
        offset: point,
        strokeCap: mxStore.strokeCap,
        strokeWidth: mxStore.strokeWidth);
    mxStore.addPayload(payload);
    socketService.emit(event: 'chat', data: payload.toJson());
  }

  void onStopDrawing() {
    socketService.emit(event: 'mouseup', data: mxStore.userid.uid);
    Payload payload = Payload(
        color: Colors.black,
        offset: null,
        strokeCap: StrokeCap.round,
        strokeWidth: 4.0,
        uid: mxStore.userid.uid);
    mxStore.addPayload(payload);
  }

  void selectEraser() {
    if (mxStore.color != Colors.white) mxStore.setSavedColor(mxStore.color);
    if (mxStore.strokeWidth != 19.0)
      mxStore.setSavedStrokeWidth(mxStore.strokeWidth);
    mxStore.setColor(Colors.white);
    mxStore.setStrokeWidth(19.0);
    mxStore.setBrushMode(true);
  }

  void selectColorPicker() {
    if (mxStore.brushMode) {
      mxStore.setSavedColor(mxStore.color);
      //if the user selects color picker from the eraser
      mxStore.setStrokeWidth(mxStore.savedStrokeWidth);
      mxStore.setBrushMode(false);
    }
  }

  void selectPencil() {
    if (mxStore.brushMode) {
      mxStore.setColor(mxStore.savedColor);
      mxStore.setStrokeWidth(mxStore.savedStrokeWidth);
      mxStore.setBrushMode(false);
    }
  }

  void emitClearToOthers() {
    socketService.emit(event: 'clear', data: null);
    mxStore.clear();
  }
}
