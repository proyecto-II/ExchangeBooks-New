import 'dart:developer';
import 'package:exchangebooks_ui/model/message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  final IO.Socket socket = IO.io(
      dotenv.env['API_URL_CHAT'],
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  Future<void> initConnection() async {
    socket.connect();
    socket.onConnect((_) => {log("Socket connection established")});
  }

  Future<void> sendMessage(Message message) async {
    socket.emit(
      'send-message',
      {
        'message': message.toJson(),
      },
    );
  }

  Future<void> joinChat(String chatId) async {
    socket.emit(
      'join-chat',
      {chatId},
    );
  }
}
