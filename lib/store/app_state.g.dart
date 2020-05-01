// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppState on _AppState, Store {
  final _$useridAtom = Atom(name: '_AppState.userid');

  @override
  FirebaseUser get userid {
    _$useridAtom.context.enforceReadPolicy(_$useridAtom);
    _$useridAtom.reportObserved();
    return super.userid;
  }

  @override
  set userid(FirebaseUser value) {
    _$useridAtom.context.conditionallyRunInAction(() {
      super.userid = value;
      _$useridAtom.reportChanged();
    }, _$useridAtom, name: '${_$useridAtom.name}_set');
  }

  final _$brushModeAtom = Atom(name: '_AppState.brushMode');

  @override
  bool get brushMode {
    _$brushModeAtom.context.enforceReadPolicy(_$brushModeAtom);
    _$brushModeAtom.reportObserved();
    return super.brushMode;
  }

  @override
  set brushMode(bool value) {
    _$brushModeAtom.context.conditionallyRunInAction(() {
      super.brushMode = value;
      _$brushModeAtom.reportChanged();
    }, _$brushModeAtom, name: '${_$brushModeAtom.name}_set');
  }

  final _$payloadsAtom = Atom(name: '_AppState.payloads');

  @override
  ObservableList<Payload> get payloads {
    _$payloadsAtom.context.enforceReadPolicy(_$payloadsAtom);
    _$payloadsAtom.reportObserved();
    return super.payloads;
  }

  @override
  set payloads(ObservableList<Payload> value) {
    _$payloadsAtom.context.conditionallyRunInAction(() {
      super.payloads = value;
      _$payloadsAtom.reportChanged();
    }, _$payloadsAtom, name: '${_$payloadsAtom.name}_set');
  }

  final _$artistsAtom = Atom(name: '_AppState.artists');

  @override
  ObservableList<String> get artists {
    _$artistsAtom.context.enforceReadPolicy(_$artistsAtom);
    _$artistsAtom.reportObserved();
    return super.artists;
  }

  @override
  set artists(ObservableList<String> value) {
    _$artistsAtom.context.conditionallyRunInAction(() {
      super.artists = value;
      _$artistsAtom.reportChanged();
    }, _$artistsAtom, name: '${_$artistsAtom.name}_set');
  }

  final _$colorAtom = Atom(name: '_AppState.color');

  @override
  Color get color {
    _$colorAtom.context.enforceReadPolicy(_$colorAtom);
    _$colorAtom.reportObserved();
    return super.color;
  }

  @override
  set color(Color value) {
    _$colorAtom.context.conditionallyRunInAction(() {
      super.color = value;
      _$colorAtom.reportChanged();
    }, _$colorAtom, name: '${_$colorAtom.name}_set');
  }

  final _$savedColorAtom = Atom(name: '_AppState.savedColor');

  @override
  Color get savedColor {
    _$savedColorAtom.context.enforceReadPolicy(_$savedColorAtom);
    _$savedColorAtom.reportObserved();
    return super.savedColor;
  }

  @override
  set savedColor(Color value) {
    _$savedColorAtom.context.conditionallyRunInAction(() {
      super.savedColor = value;
      _$savedColorAtom.reportChanged();
    }, _$savedColorAtom, name: '${_$savedColorAtom.name}_set');
  }

  final _$savedStrokeWidthAtom = Atom(name: '_AppState.savedStrokeWidth');

  @override
  double get savedStrokeWidth {
    _$savedStrokeWidthAtom.context.enforceReadPolicy(_$savedStrokeWidthAtom);
    _$savedStrokeWidthAtom.reportObserved();
    return super.savedStrokeWidth;
  }

  @override
  set savedStrokeWidth(double value) {
    _$savedStrokeWidthAtom.context.conditionallyRunInAction(() {
      super.savedStrokeWidth = value;
      _$savedStrokeWidthAtom.reportChanged();
    }, _$savedStrokeWidthAtom, name: '${_$savedStrokeWidthAtom.name}_set');
  }

  final _$strokeCapAtom = Atom(name: '_AppState.strokeCap');

  @override
  StrokeCap get strokeCap {
    _$strokeCapAtom.context.enforceReadPolicy(_$strokeCapAtom);
    _$strokeCapAtom.reportObserved();
    return super.strokeCap;
  }

  @override
  set strokeCap(StrokeCap value) {
    _$strokeCapAtom.context.conditionallyRunInAction(() {
      super.strokeCap = value;
      _$strokeCapAtom.reportChanged();
    }, _$strokeCapAtom, name: '${_$strokeCapAtom.name}_set');
  }

  final _$strokeWidthAtom = Atom(name: '_AppState.strokeWidth');

  @override
  double get strokeWidth {
    _$strokeWidthAtom.context.enforceReadPolicy(_$strokeWidthAtom);
    _$strokeWidthAtom.reportObserved();
    return super.strokeWidth;
  }

  @override
  set strokeWidth(double value) {
    _$strokeWidthAtom.context.conditionallyRunInAction(() {
      super.strokeWidth = value;
      _$strokeWidthAtom.reportChanged();
    }, _$strokeWidthAtom, name: '${_$strokeWidthAtom.name}_set');
  }

  final _$_AppStateActionController = ActionController(name: '_AppState');

  @override
  dynamic addPayload(Payload payload) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.addPayload(payload);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addArtists(String artist) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.addArtists(artist);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clear() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.clear();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBrushMode(bool i) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setBrushMode(i);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSavedColor(Color i) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setSavedColor(i);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSavedStrokeWidth(double i) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setSavedStrokeWidth(i);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserId(FirebaseUser user) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setUserId(user);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStrokeWidth(double i) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setStrokeWidth(i);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStrokeCap(StrokeCap i) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setStrokeCap(i);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setColor(Color i) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setColor(i);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'userid: ${userid.toString()},brushMode: ${brushMode.toString()},payloads: ${payloads.toString()},artists: ${artists.toString()},color: ${color.toString()},savedColor: ${savedColor.toString()},savedStrokeWidth: ${savedStrokeWidth.toString()},strokeCap: ${strokeCap.toString()},strokeWidth: ${strokeWidth.toString()}';
    return '{$string}';
  }
}
