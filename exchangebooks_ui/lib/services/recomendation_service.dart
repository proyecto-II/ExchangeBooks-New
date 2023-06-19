import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/book_recomendation.dart';

class RecomendationService {
  final url = dotenv.env['API_URL_AWS'];
  final apiUrl = dotenv.env['API_URL'];

  Future<List<BookRecomendation>> getRecomendations(String categories) async {
    List<BookRecomendation> recomendations = [];
    try {
      final response =
          await http.post(Uri.parse('$apiUrl/api/recomendation/books'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "categories": categories,
              }));
      final jsonData = json.decode(response.body) as List<dynamic>;
      for (var item in jsonData) {
        BookRecomendation book = BookRecomendation.fromJson(item);
        recomendations.add(book);
      }

      return recomendations;
    } catch (error) {
      log('Error ocurrido en PostService $error');
      return recomendations;
    }
  }
}
