import 'package:exchangebooks_ui/model/genre.dart';
import 'package:exchangebooks_ui/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class GenreProvider extends ChangeNotifier {
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
