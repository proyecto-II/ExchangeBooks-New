import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/genre.dart';

class UserService {
  final url = dotenv.env['API_URL'];

  Future<String> updateAvatar(String image) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("http://192.168.43.4:3004/file?folder=avatars"));
      request.files.add(await http.MultipartFile.fromPath('files', image));
      final response = await request.send();
      if (response.statusCode == 200) {
        final result = await json.decode(await response.stream.bytesToString());
        return result["location"];
      }
      return "";
    } catch (e) {
      log('Paso por aqui ${e.toString()}');
      return "";
    }
  }

  Future<void> updateUser(String id, String name, String username,
      String lastname, String location) async {
    try {
      final user = {
        'name': name,
        'username': username,
        'lastname': lastname,
        "photoUrl": location
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

  Future<void> updateGenresUser(String email, List<Genre> genres) async {
    try {
      final update = {
        'userId': email,
        'genres': genres.map((genre) => genre.toJson()).toList()
      };
      log(update.toString());
      var response = await http.put(
        Uri.parse("$url/api/genre/user/update/$email"),
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

  Future<List<Genre>> getGenresByUser(String email) async {
    List<Genre> genres = [];
    try {
      final response = await http.get(
        Uri.parse('$url/api/genre/user/$email'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonData = json.decode(response.body) as Map<String, dynamic>;

      if (jsonData.containsKey("genres") &&
          jsonData["genres"] is List<dynamic>) {
        final data = jsonData["genres"] as List<dynamic>;
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            Genre genre = Genre.fromJson(item);

            genres.add(genre);
          }
        }
      }

      return genres;
    } catch (error) {
      log(error.toString());
      return genres;
    }
  }
}
