import 'dart:convert';
import 'dart:developer';
import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookService {
  final apiUrl = dotenv.env['API_URL'];

  Future<List<BookUser>> getAllBooks() async {
    List<BookUser> books = [];

    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/book/list'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonData = json.decode(response.body) as List<dynamic>;

      for (var item in jsonData) {
        BookUser book = BookUser.fromJson(item);
        books.add(book);
      }
      return books;
    } catch (error) {
      log('Error ocurrido en PostServiceFilter $error');
      return books;
    }
  }

  Future<List<BookUser>> filterBooks(List<String> booksIds) async {
    final data = {'genres': booksIds};
    List<BookUser> books = [];

    try {
      final response = await http.post(Uri.parse('$apiUrl/api/book/filter'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
      final jsonData = json.decode(response.body) as List<dynamic>;
      log(jsonData.toString());
      for (var item in jsonData) {
        BookUser book = BookUser.fromJson(item);
        books.add(book);
      }
      return books;
    } catch (error) {
      log('Error ocurrido en PostServiceFilter $error');
      return books;
    }
  }
}
