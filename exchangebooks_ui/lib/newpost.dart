import 'dart:convert';
import 'dart:io';
import 'package:exchangebooks_ui/utils/photo_convert.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'model/genre.dart';
import 'widgets/drawer.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewPost createState() => _NewPost();
}

class _NewPost extends State<NewPostPage> {
  TextEditingController? titleController;
  TextEditingController? authorController;
  TextEditingController? descriptionController;
  late List<Genre>? selectedGenreList = [];
  late List<Genre> genreList = [];
  final ImagePicker _picker = ImagePicker();
  String _photoName = '';

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
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: const Drawers(),
      body: SafeArea(
        child: _form(),
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
    return ElevatedButton(
      onPressed: () {
        openFilterDialog();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[600],
        minimumSize: const Size(100, 35),
        side: const BorderSide(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('Ver generos'), Icon(Icons.add)],
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
              File file = File(imgFile!.path);
              _photoName = Utility.base64String(file.readAsBytesSync());
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
        Navigator.of(context).pop();
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
}
