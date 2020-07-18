import 'package:my_frontend/global.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ENV { LOCAL, DEV, PROD }
final env = ENV.DEV;

String getUrl() {
  switch (env) {
    case ENV.LOCAL:
      return "http://localhost:8080";
    case ENV.DEV:
      return "https://whiteboard-be-dev.herokuapp.com";
    case ENV.PROD:
      return "https://whiteboard-be.herokuapp.com";
  }
}

class SocketIOSerivce {
  IO.Socket socket = IO.io(getUrl(), <String, dynamic>{
    'transports': ['websocket'] // optional
  });

  void handleConnect() {
    this.socket.on('connect', (data) {
      // print("Connect");
      //Send the userid to backend in order to save it in database
      this.socket.emit('userid', mxStore.userid.uid);
    });
  }

  void handleDisconnect() {
    this.socket.on('disconnect', (data) {
      print("Disconnected");
    });
  }

  void received({String event, Function(dynamic data) callback}) {
    this.socket.on(event, (data) {
      callback(data);
    });
  }

  void emit({String event, dynamic data}) {
    this.socket.emitWithAck(event, data, ack: (_) {});
  }

  void init() {
    handleDisconnect();
    this.socket.on('connect_error', (data) => print("Error"));
    this.socket.on('reconnect_failed', (data) => print("reconnect_failed"));
    this.socket.on('reconnect_error', (data) => print("reconnect_error"));
    this.socket.on('reconnecting', (data) => print("reconnecting"));
  }
}
