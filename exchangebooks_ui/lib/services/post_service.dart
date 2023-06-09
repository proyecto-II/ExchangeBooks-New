import 'dart:convert';
import 'dart:developer';
import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/book.dart';
import '../model/genre.dart';

class PostService {
  final url = dotenv.env['API_URL_AWS'];
  final apiUrl = dotenv.env['API_URL'];

  Future<void> createPost(String title, String author, String description,
      String userId, List<Genre> genres, String type, String image) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/book/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'title': title,
          'author': author,
          'description': description,
          'userId': userId,
          'genres': genres.map((genre) => genre.toJson()).toList(),
          'type': type,
          'images': {"_id": image}
        }),
      );
      final jsonData = json.decode(response.body);
      log(jsonData);
    } catch (err) {
      log('Error de Post $err');
    }
  }

  Future<String> postImage(String image) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse("$url/file?folder=books"));
      request.files.add(await http.MultipartFile.fromPath('files', image));
      final response = await request.send();

      if (response.statusCode != 200) {
        return 'Sucedio un error ${response.statusCode}';
      }

      final result = await json.decode(await response.stream.bytesToString());
      return result["location"];
    } catch (error) {
      log(error.toString());
      return 'Error al subir la imagen';
    }
  }

  Future<List<BookUser>> getAllPosts() async {
    List<BookUser> posts = [];
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
        posts.add(book);
      }
      return posts;
    } catch (error) {
      log('Error ocurrido en PostService $error');
      return posts;
    }
  }

  Future<List<BookUser>> getFilterPosts(String filterPrefix) async {
    List<BookUser> posts = [];
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/book/search?q=$filterPrefix'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonData = json.decode(response.body) as List<dynamic>;
      log(jsonData.toString());
      for (var item in jsonData) {
        BookUser book = BookUser.fromJson(item);
        posts.add(book);
      }
      return posts;
    } catch (error) {
      log('Error ocurrido en PostServiceFilter $error');
      return posts;
    }
  }

  Future<BookUser?> getPostById(String id) async {
    BookUser post;
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/book/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonData = json.decode(response.body);
      post = BookUser.fromJson(jsonData);
      return post;
    } catch (error) {
      log('Error ocurrido en getPostById $error');
      return null;
    }
  }

  Future<void> editPost(String id, String userId, Book post) async {
    try {
      final book = {
        'title': post.title,
        'author': post.author,
        'userId': userId,
        "description": post.description,
        "genres": post.genres,
        "type": post.type,
        "images": post.images,
      };
      var response = await http.put(
        Uri.parse("$url/api/book/edit/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(book),
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
}
