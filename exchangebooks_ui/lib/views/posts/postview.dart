import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/services/post_service.dart';
import 'package:exchangebooks_ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../provider/google_sign_in.dart';
import '../chat/messages_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.idBook}) : super(key: key);
  final String idBook;

  @override
  // ignore: library_private_types_in_public_api
  _PostView createState() => _PostView();
}

class _PostView extends State<PostPage> {
  late BookUser book;

  @override
  void initState() {
    super.initState();
  }

  Future<BookUser?> getBook(String idBook) async {
    book = (await PostService().getPostById(idBook))!;
    return book;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iuser = Provider.of<GoogleSignInProvider>(context);
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
            body: InteractiveViewer(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const Gap(10),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              ' Otros libros',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Ver todo >'))
                          ],
                        ),
                      ),
                      const Gap(10),
                      _postList(),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: snapshot.data!.user!.id != iuser.user!.id
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              MessagesPage(user: snapshot.data!.user!),
                        ),
                      );
                    },
                    label: const Text('Intercambiar'),
                    icon: const Icon(Icons.message),
                    backgroundColor: Colors.orange[800],
                    splashColor: Colors.purple,
                  )
                : null,
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        return const Center(child: CircularProgressIndicator.adaptive());
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
                        'Publicado por:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book.user!.username!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Gap(15),
                      const Text(
                        'Géneros',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _genres(),
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
      ),
    );
  }

  Widget _postList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
              //Componente agregado ya que sin el SizedBox el texto mueve a los demas componentes
              width: 150,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://ekaresur.cl/cms/wp-content/uploads/2019/04/veronica-uribe-el-libro-de-oro-de-los-cuentos-de-hadas-1.jpg',
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(25),
                        const Text(
                          'El libro de la vida',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
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
}
