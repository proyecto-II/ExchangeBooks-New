import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  final apiUrl = dotenv.env['API_URL'];
  final IO.Socket socket = IO.io(
      'http://192.168.20.69:3008',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  Future<void> initConnection() async {
    socket.connect();
    socket.onConnect((_) => {print("Socket connection established")});
  }
}
