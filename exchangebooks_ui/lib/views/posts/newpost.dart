import 'dart:convert';
import 'dart:io';
import 'package:exchangebooks_ui/layouts/main_layout.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/services/post_service.dart';
import 'package:exchangebooks_ui/utils/photo_convert.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../model/genre.dart';
import '../../services/genre_service.dart';
import '../../widgets/drawer.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewPost createState() => _NewPost();
}

class _NewPost extends State<NewPostPage> {
  TextEditingController? titleController = TextEditingController();
  TextEditingController? authorController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  late List<Genre>? selectedGenreList = [];
  late List<Genre> genreList = [];
  final ImagePicker _picker = ImagePicker();
  String _photoName = '';
  File? _imageTaken;

  @override
  void initState() {
    getGenres();
    super.initState();
  }

  Future<void> getGenres() async {
    List<Genre> genres = await GenreService().getGenres();
    setState(() {
      genreList = genres;
    });
  }

  Future<void> _createPost() async {
    final iuser = Provider.of<GoogleSignInProvider>(context, listen: false);
    final location = await PostService().postImage(_imageTaken!.path);
    await PostService().createPost(
        titleController!.text,
        authorController!.text,
        descriptionController!.text,
        iuser.user!.id!,
        selectedGenreList!,
        'Libro',
        location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Nueva Publicación',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: const Drawers(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _form(),
        ),
      ),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(243, 248, 255, 1),
              labelText: "Titulo",
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const Gap(20),
          const Text(
            'Generos al que pertenece',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          _buttonGenre(),
          _genresSelected(context),
          const Gap(15),
          TextField(
            controller: authorController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(243, 248, 255, 1),
              labelText: "Autor",
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const Gap(10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: TextField(
              maxLines: 100,
              controller: descriptionController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(243, 248, 255, 1),
                labelText: 'Descripción',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text('Suba fotografias del libro',
                style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
          //Aqui deberia ir la elección de imagenes
          _camera(),
          const Gap(20),
          _buttonPost(),
        ],
      ),
    );
  }

  Widget _buttonGenre() {
    return Row(
      children: [
        const Text(
          "Generos",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              openFilterDialog();
            },
            icon: const Icon(LineAwesomeIcons.plus))
      ],
    );
  }

  Widget _genresSelected(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedGenreList!.length,
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
                selectedGenreList!.elementAt(index).name.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _camera() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          _picker
              .pickImage(
                  source: ImageSource != null
                      ? ImageSource.camera
                      : ImageSource.gallery)
              .then(
            (imgFile) {
              _imageTaken = File(imgFile!.path);
              _photoName = Utility.base64String(_imageTaken!.readAsBytesSync());
              setState(() {});
            },
          );
        },
        child: SizedBox(
          width: 250,
          height: 150,
          child: _photoName != null
              ? Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  // ignore: unnecessary_new
                  child: _photoName.isNotEmpty
                      ? Image.memory(
                          base64Decode(_photoName),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.purple),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 50,
                          ),
                        ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 100,
                  height: 100,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 249, 250, 249),
                  ),
                ),
        ),
      ),
    );
  }

  void openFilterDialog() async {
    await FilterListDialog.display<Genre>(
      context,
      listData: genreList,
      selectedListData: selectedGenreList,
      applyButtonText: 'Aplicar',
      allButtonText: 'Todo',
      resetButtonText: 'Revertir',
      selectedItemsText: 'Generos seleccionados',
      themeData: FilterListThemeData(
        context,
        choiceChipTheme:
            const ChoiceChipThemeData(selectedBackgroundColor: Colors.amber),
        headerTheme:
            const HeaderThemeData(searchFieldHintText: "Buscar generos"),
      ),
      choiceChipLabel: (genre) => genre!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (genre, query) {
        return genre.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedGenreList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buttonPost() {
    return ElevatedButton(
      onPressed: () async {
        _showAlert(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent[1000],
        minimumSize: const Size(200, 50),
        side: const BorderSide(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: const Text('Publicar'),
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
                '¿Está seguro de querer realizar esta acción?',
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
                _createPost();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MainLayout()));
                // ignore: use_build_context_synchronously
                _successAlert(context);
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

  void _successAlert(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return (AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(width: 100, height: 100, 'assets/img/success.png'),
              const Text(
                '¡¡Se ha publicado el libro con exito!!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        ));
      },
    );
  }
}
