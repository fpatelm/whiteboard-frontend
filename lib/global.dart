import 'dart:ui';

import 'package:my_frontend/store/app_state.dart';

final mxStore = AppState(); // Instantiate the store
enum ENV { DEV, PROD }
final env = ENV.PROD;

String getUrl() {
  switch (env) {
    case ENV.DEV:
      return "http://localhost:8080";
    case ENV.PROD:
      return "https://whiteboard-be.herokuapp.com";
  }
}

extension OffsetManagment on Offset {
  dynamic toJson() {
    return {'dx': this.dx, 'dy': this.dy};
  }
}
