import 'package:exchangebooks_ui/model/genre.dart';
import 'package:exchangebooks_ui/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenreProvider extends ChangeNotifier {
  final apiUrl = dotenv.env['API_URL'];
  final userService = UserService();

  List<Genre>? _genres;

  List<Genre>? get genres => _genres;

  void setGenres(List<Genre>? genres) {
    _genres = genres;
    notifyListeners();
  }

  Future<void> getGenres(String email) async {
    List<Genre> genres = await userService.getGenresByUser(email);
    setGenres(genres);
    notifyListeners();
  }
}
