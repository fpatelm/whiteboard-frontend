// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppState on _AppState, Store {
  Computed<Map<String, ObservableList<String>>> _$storeListComputed;

  @override
  Map<String, ObservableList<String>> get storeList => (_$storeListComputed ??=
          Computed<Map<String, ObservableList<String>>>(() => super.storeList))
      .value;

  final _$conectionStateAtom = Atom(name: '_AppState.conectionState');

  @override
  String get conectionState {
    _$conectionStateAtom.context.enforceReadPolicy(_$conectionStateAtom);
    _$conectionStateAtom.reportObserved();
    return super.conectionState;
  }

  @override
  set conectionState(String value) {
    _$conectionStateAtom.context.conditionallyRunInAction(() {
      super.conectionState = value;
      _$conectionStateAtom.reportChanged();
    }, _$conectionStateAtom, name: '${_$conectionStateAtom.name}_set');
  }

  final _$indexAtom = Atom(name: '_AppState.index');

  @override
  int get index {
    _$indexAtom.context.enforceReadPolicy(_$indexAtom);
    _$indexAtom.reportObserved();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.context.conditionallyRunInAction(() {
      super.index = value;
      _$indexAtom.reportChanged();
    }, _$indexAtom, name: '${_$indexAtom.name}_set');
  }

  final _$textFromServerAtom = Atom(name: '_AppState.textFromServer');

  @override
  String get textFromServer {
    _$textFromServerAtom.context.enforceReadPolicy(_$textFromServerAtom);
    _$textFromServerAtom.reportObserved();
    return super.textFromServer;
  }

  @override
  set textFromServer(String value) {
    _$textFromServerAtom.context.conditionallyRunInAction(() {
      super.textFromServer = value;
      _$textFromServerAtom.reportChanged();
    }, _$textFromServerAtom, name: '${_$textFromServerAtom.name}_set');
  }

  final _$_myListAtom = Atom(name: '_AppState._myList');

  @override
  ObservableList<String> get _myList {
    _$_myListAtom.context.enforceReadPolicy(_$_myListAtom);
    _$_myListAtom.reportObserved();
    return super._myList;
  }

  @override
  set _myList(ObservableList<String> value) {
    _$_myListAtom.context.conditionallyRunInAction(() {
      super._myList = value;
      _$_myListAtom.reportChanged();
    }, _$_myListAtom, name: '${_$_myListAtom.name}_set');
  }

  final _$pointsAtom = Atom(name: '_AppState.points');

  @override
  ObservableList<Offset> get points {
    _$pointsAtom.context.enforceReadPolicy(_$pointsAtom);
    _$pointsAtom.reportObserved();
    return super.points;
  }

  @override
  set points(ObservableList<Offset> value) {
    _$pointsAtom.context.conditionallyRunInAction(() {
      super.points = value;
      _$pointsAtom.reportChanged();
    }, _$pointsAtom, name: '${_$pointsAtom.name}_set');
  }

  final _$_AppStateActionController = ActionController(name: '_AppState');

  @override
  dynamic setIndex(int value) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setIndex(value);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setConnectionState(String value) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setConnectionState(value);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setText(String value) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setText(value);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addList(String input) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.addList(input);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPoints(double a, double b) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.addPoints(a, b);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPoint(Offset point) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.addPoint(point);
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
  dynamic resetIndex() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.resetIndex();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'conectionState: ${conectionState.toString()},index: ${index.toString()},textFromServer: ${textFromServer.toString()},points: ${points.toString()},storeList: ${storeList.toString()}';
    return '{$string}';
  }
}
