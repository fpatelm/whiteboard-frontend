import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:my_frontend/models/Payload.dart';

part 'app_state.g.dart';

class AppState extends _AppState with _$AppState {
  AppState();
}

// The store-class
abstract class _AppState with Store {
  @observable
  FirebaseUser userid;

  @observable
  bool brushMode = false;

  @observable
  ObservableList<Payload> payloads = new ObservableList<Payload>();

  @observable
  ObservableList<String> artists = new ObservableList<String>();

  @observable
  Color color = Colors.blue;

  @observable
  Color savedColor = Colors.blue;

  @observable
  double savedStrokeWidth = 4.0;

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
  addArtists(String artist) {
    if (artists.where((element) => element == artist).isEmpty) {
      ObservableList<String> _tempArtists = new ObservableList<String>();
      _tempArtists.addAll(artists);
      _tempArtists.add(artist);
      artists = _tempArtists;
    }

    print(artists);
  }

  @action
  clear() {
    payloads.clear();
    payloads = new ObservableList<Payload>();
  }

  @action
  setBrushMode(bool i) => brushMode = i;

  @action
  setSavedColor(Color i) => savedColor = i;

  @action
  setSavedStrokeWidth(double i) => savedStrokeWidth = i;

  @action
  setUserId(FirebaseUser user) => userid = user;

  @action
  setStrokeWidth(double i) => strokeWidth = i;

  @action
  setStrokeCap(StrokeCap i) => strokeCap = i;

  @action
  setColor(Color i) => color = i;
}
