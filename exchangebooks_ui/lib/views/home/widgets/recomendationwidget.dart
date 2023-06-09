import 'package:exchangebooks_ui/model/book_recomendation.dart';
import 'package:exchangebooks_ui/services/recomendation_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Recomendations extends StatefulWidget {
  const Recomendations({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Recomendations createState() => _Recomendations();
}

class _Recomendations extends State<Recomendations> {
  List<BookRecomendation> books = [];
  bool isLoading = true;
  final RecomendationService _recomendationService = RecomendationService();

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    try {
      List<BookRecomendation> bookList =
          await _recomendationService.getRecomendations("Accion, fantasia");
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 390,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                BookRecomendation book = books[index];
                return GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                      //Componente agregado ya que sin el SizedBox el texto mueve a los demas componentes
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                book.image!,
                                width: 150,
                                height: 225,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Gap(15),
                            Text(
                              book.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Gap(10),
                            Text(
                              book.author!,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
    );
  }
}
