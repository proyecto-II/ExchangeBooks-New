import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  io.Socket socket = io.io(
      dotenv.env['API_URL_CHAT'],
      io.OptionBuilder()
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
