import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/services/post_service.dart';
import 'package:exchangebooks_ui/views/posts/user_editpost.dart';
import 'package:exchangebooks_ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

import '../../layouts/main_layout.dart';

class UserPostPage extends StatefulWidget {
  const UserPostPage({Key? key, required this.idBook}) : super(key: key);
  final String idBook;

  @override
  // ignore: library_private_types_in_public_api
  _UserPostView createState() => _UserPostView();
}

class _UserPostView extends State<UserPostPage> {
  late BookUser book;
  String _isError = 'error';

  @override
  void initState() {
    super.initState();
  }

  Future<BookUser?> getBook(String idBook) async {
    book = (await PostService().getPostById(idBook))!;
    return book;
  }

  Future<String> deleteBook() async {
    String isError = await PostService().deleteBook(book.id!);
    setState(() {
      _isError = isError;
    });
    return isError;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _postImage(),
                      const Gap(10),
                      FittedBox(
                        child: Text(
                          book.title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Gap(20),
                      const Text(
                        'Generos:',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      const Gap(5),
                      _genres(context),
                      const Gap(10),
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
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPostPage(book: book),
                      ),
                    );
                  },
                  label: const Text('Editar'),
                  icon: const Icon(Icons.edit),
                  backgroundColor: Colors.blue[800],
                  splashColor: Colors.purple,
                  heroTag: 'editar',
                ),
                const Gap(5),
                FloatingActionButton.extended(
                  onPressed: () async {
                    await deleteBook();
                    if (_isError != 'error') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainLayout()));
                      _showAlert(context);
                    } else {
                      _showError(context);
                    }
                  },
                  label: const Text('Eliminar'),
                  icon: const Icon(LineAwesomeIcons.trash),
                  backgroundColor: Colors.red[800],
                  splashColor: Colors.purple,
                  heroTag: 'eliminar',
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _postImage() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _zoomImage(context);
        });
      },
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            book.images!.first,
            height: 220,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /*
  * Book genres
  * @param {BuildContext} context
  * @return {Widget} Widget
  */
  Widget _genres(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: book.genres!.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.amber[800],
                borderRadius: BorderRadius.circular(100)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                book.genres!.elementAt(index).name.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
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

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return (AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'Libro eliminado con exito',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                await Future.delayed(
                  const Duration(seconds: 2),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('Continuar'),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        ));
      },
    );
  }

  void _showError(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return (AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Hubo un error al intentar eliminar el libro'),
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('OK')),
          ],
        ));
      },
    );
  }
}
