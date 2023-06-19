import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/services/post_service.dart';
import 'package:exchangebooks_ui/views/posts/user_editpost.dart';
import 'package:exchangebooks_ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class UserPostPage extends StatefulWidget {
  const UserPostPage({Key? key, required this.idBook}) : super(key: key);
  final String idBook;

  @override
  // ignore: library_private_types_in_public_api
  _UserPostView createState() => _UserPostView();
}

class _UserPostView extends State<UserPostPage> {
  late BookUser book;

  @override
  void initState() {
    super.initState();
  }

  Future<BookUser?> getBook(String idBook) async {
    book = (await PostService().getPostById(idBook))!;
    return book;
  }

  void deleteBook() async {
    await PostService().deleteBook(book.id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBook(widget.idBook),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(248, 255, 255, 255),
              centerTitle: true,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Exchangebook',
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            drawer: const Drawers(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Editar',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditPostPage(book: book),
                                  ),
                                );
                              },
                              icon: const Icon(
                                LineAwesomeIcons.edit,
                                color: Colors.blue,
                                size: 50,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Eliminar',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          IconButton(
                              onPressed: () {
                                deleteBook();
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                LineAwesomeIcons.trash,
                                color: Colors.red,
                                size: 50,
                              )),
                        ],
                      ),
                      _post(),
                      const Gap(20),
                      const Text(
                        'Descripción',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      const Gap(10),
                      SizedBox(
                        height: 270,
                        child: SingleChildScrollView(
                          child: Text(
                            book.description!,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _post() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Gap(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _zoomImage(context);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    book.images!.first,
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        book.author!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Gap(10),
                      const Text(
                        'Géneros',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _genres()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genres() {
    return SizedBox(
        width: 200,
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: book.genres!.length,
          itemBuilder: (context, index) {
            return Text('${book.genres!.elementAt(index).name!} ');
          },
        ));
  }

  // ignore: slash_for_doc_comments
  /***
  * Widget que permite hacerle zoom a la imagen del libro
  * @param {BuildContext context} Parametro que es usado para realizar llamadas a distintos widgets u obtener datos del widget anterior.
  * @return Un Dialog con la imagen en la cual se le puede hacer gracias a la libreria PhotoView, la que trabaja con InteractiveViewer para los cambios de tamaño de la imagen
  ***/
  void _zoomImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PhotoView(
                      imageProvider: NetworkImage(book.images!.first),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}