import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/services/book_service.dart';
import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  final bookService = BookService();

  List<BookUser>? _books;

  List<BookUser>? get books => _books;

  void setSearchBooks(List<BookUser>? books) {
    _books = books;
    notifyListeners();
  }

  Future<void> filterBooks(List<String> ids) async {
    List<BookUser> books =
        _books!.where((book) => book.genres!.contains(ids[0])).toList();
    setSearchBooks(books);
    notifyListeners();
  }

  Future<void> getAllBooks() async {
    List<BookUser> books = await bookService.getAllBooks();
    print("search books");
    print(books.length);
    setSearchBooks(books);
    notifyListeners();
  }
}
