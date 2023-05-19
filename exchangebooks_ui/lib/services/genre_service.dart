import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/genre.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class GenreService {
  final url = dotenv.env['API_URL'];

  Future<List<Genre>> getGenres() async {
    List<Genre> genres = [];
    try {
      final response = await http.get(
        Uri.parse('$url/api/genre/list'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final jsonData = json.decode(response.body) as Map<String, dynamic>;

      if (jsonData.containsKey("data") && jsonData["data"] is List<dynamic>) {
        final data = jsonData["data"] as List<dynamic>;
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
