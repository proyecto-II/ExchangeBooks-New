import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../posts/postview.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BooksList createState() => _BooksList();
}

class _BooksList extends State<BooksList> {
  List<BookUser> books = [];
  bool isLoading = true;
  final BookService _bookService = BookService();

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    try {
      List<BookUser> bookList = await _bookService.getAllBooks();
      setState(() {
        books = bookList;
        isLoading = false;
      });
    } catch (error) {
      // Manejo de errores
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: books.length,
              itemBuilder: (context, index) {
                BookUser book = books[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostPage(
                          bookUser: books.elementAt(index),
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 150,
                    child: FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                book.images![0],
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(4),
                          Text(
                            book.title!,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
