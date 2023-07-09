import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final apiUrl = dotenv.env['API_URL'];

  // Future<HttpResponse> getUserChats(String userId) async {
  //   List<Chat> chats = [];

  //   try {
  //     final response = await http.get(
  //       Uri.parse('$apiUrl/api/chat/user/$userId'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     final jsonData = json.decode(response.body) as List<dynamic>;

  //     for (var item in jsonData) {
  //       Chat chat = Chat.fromJson(item);
  //       chats.add(chat);
  //     }
  //     return chats;
  //   } catch (error) {
  //     log('Error ocurrido al obtener los chats del usuario: $error');
  //     return chats;
  //   }
  // }

  Future<http.Response> getUserChats(String userId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/api/chat/user/$userId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  Future<http.Response> getChatMessages(String chatId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/api/chat/$chatId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  Future<http.Response> createChat(String sender, List<String> members) async {
    final response = await http.post(Uri.parse('$apiUrl/api/chat/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'sender': sender, 'members': members}));

    return response;
  }
}
