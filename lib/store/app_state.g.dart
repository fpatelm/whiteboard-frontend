// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppState on _AppState, Store {
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
  dynamic clear() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.clear();
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
        'payloads: ${payloads.toString()},color: ${color.toString()},strokeCap: ${strokeCap.toString()},strokeWidth: ${strokeWidth.toString()}';
    return '{$string}';
  }
}
