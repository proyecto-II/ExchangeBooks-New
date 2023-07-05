import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  IO.Socket socket = IO.io(
      dotenv.env['API_URL_CHAT'],
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal();

  void initSocket() {
    socket.connect();
    socket.onConnect((_) => {log("Socket connection established")});
  }
}
