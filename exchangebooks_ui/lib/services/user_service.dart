import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/genre.dart';

class UserService {
  final url = dotenv.env['API_URL'];

  Future<void> updateUser(
      String id, String name, String username, String lastname) async {
    try {
      final user = {
        'id': id,
        'name': name,
        'username': username,
        'lastname': lastname
      };
      var response = await http.put(
        Uri.parse("$url/api/auth/updateUser/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user),
      );
      if (response.statusCode != 200) {
        log(response.statusCode.toString());
      }
      var result = jsonDecode(response.body);
      log(result);
    } catch (e) {
      log('Paso por aqui ${e.toString()}');
    }
  }

  Future<void> updateGenresUser(String id, List<Genre> genres) async {
    try {
      final update = {
        'userId': id,
        'genres': genres.map((genre) => genre.toJson()).toList()
      };
      log(update.toString());
      var response = await http.put(
        Uri.parse("$url/api/genre/update/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(update),
      );
      if (response.statusCode != 200) {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
