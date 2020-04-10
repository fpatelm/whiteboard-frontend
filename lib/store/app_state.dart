import 'dart:ui';

import 'package:mobx/mobx.dart';

part 'app_state.g.dart';

class AppState extends _AppState with _$AppState {
  AppState() {
    this.resetIndex();
    this.textFromServer = null;
  }
}

// The store-class
abstract class _AppState with Store {
  @observable
  String conectionState;

  @observable
  int index;

  @observable
  String textFromServer = "";

  @observable
  ObservableList<String> _myList = new ObservableList<String>();

  @observable
  ObservableList<Offset> points = new ObservableList<Offset>();

  @computed
  Map<String, ObservableList<String>> get storeList => {'point': _myList};

  @action
  setIndex(int value) {
    print("set state$value");
    index = value;
  }

  @action
  setConnectionState(String value) {
    conectionState = value;
  }

  @action
  setText(String value) {
    textFromServer = value;
  }

  @action
  addList(String input) {
    this._myList.add(input);
  }

  @action
  addPoints(double a, double b) => this.points
    ..add(new Offset(
      a,
      b,
    ));

  @action
  addPoint(Offset point) =>
      points = (List.from(points) as ObservableList)..add(point);

  @action
  clear() {
    this.points.clear();
    this._myList.clear();
  }

  @action
  resetIndex() {
    index = 0;
  }
}
