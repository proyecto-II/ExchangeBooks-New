import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'provider/genre_list.dart';
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
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
          TextFormField(
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
          TextFormField(
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
            height: 200,
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
          //Aqui deberia ir la elección de imagenes
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
}
