import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:my_frontend/service/app.dart';
import 'package:my_frontend/service/firestore.dart';
import 'package:my_frontend/service/socketio.dart';
import 'package:my_frontend/store/app_state.dart';

final mxStore = AppState(); // Instantiate the store
final SocketIOSerivce socketService = SocketIOSerivce();
final fireStoreService = FirestoreService();
final appService = BoardAppService();

extension OffsetManagment on Offset {
  dynamic toJson() {
    return {'dx': this.dx, 'dy': this.dy};
  }

  void blabla() {}
}

extension StrokeCapManagement on StrokeCap {
  dynamic toJson() {
    return {'_strokeCap': this.toString()};
  }
}

extension ColorManagement on Color {
  dynamic toJson() {
    return {'r': this.red, 'g': this.green, 'b': this.blue};
  }
}
