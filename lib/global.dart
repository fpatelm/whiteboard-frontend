import 'dart:ui';

import 'package:my_frontend/store/app_state.dart';

final mxStore = AppState(); // Instantiate the store

extension OffsetManagment on Offset {
  dynamic toJson() {
    return {'dx': this.dx, 'dy': this.dy};
  }
}
