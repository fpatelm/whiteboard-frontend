import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:my_frontend/models/Payload.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../global.dart';

part 'app_state.g.dart';

class AppState extends _AppState with _$AppState {
  AppState();
}

// The store-class
abstract class _AppState with Store {
  IO.Socket socket = IO.io(getUrl(), <String, dynamic>{
    'transports': ['websocket'] // optional
  });

  @observable
  ObservableList<Payload> payloads = new ObservableList<Payload>();

  @observable
  Color color = Colors.blue;

  @observable
  StrokeCap strokeCap = StrokeCap.round;

  @observable
  double strokeWidth = 4.0;

  @action
  addPayload(Payload payload) {
    ObservableList<Payload> _tempPayload = new ObservableList<Payload>();
    _tempPayload.addAll(payloads);
    _tempPayload.add(payload);
    payloads = _tempPayload;
  }
  @action
  clear() {
    payloads.clear();
    payloads = new ObservableList<Payload>();
  }

  @action
  setStrokeWidth(double i) => strokeWidth = i;

  @action
  setStrokeCap(StrokeCap i) => strokeCap = i;

  @action
  setColor(Color i) => color = i;
}
