import 'package:exchangebooks_ui/provider/genre_list.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Genres createState() => _Genres();
}

class _Genres extends State<GenrePage> {
  final List<Genre>? selectedGenreList =
      []; //Esto es un test del filtro de preferencias

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Elige tus géneros favoritos',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: FilterListWidget<Genre>(
          listData: genreList,
          selectedListData: selectedGenreList,
          enableOnlySingleSelection: false,
          hideSelectedTextCount: true,
          applyButtonText: "Registrarse",
          resetButtonText: "Eliminar todo",
          allButtonText: "Todo",
          themeData: const FilterListThemeData.raw(
              choiceChipTheme: ChoiceChipThemeData(
                selectedBackgroundColor: Colors.amber,
                side: BorderSide(style: BorderStyle.solid),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                selectedShape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              headerTheme:
                  HeaderThemeData(searchFieldHintText: "Buscar Genero"),
              controlBarButtonTheme: ControlButtonBarThemeData.raw(
                controlButtonTheme: ControlButtonThemeData(
                    primaryButtonBackgroundColor: Colors.amber),
              ),
              borderRadius: 1,
              wrapAlignment: WrapAlignment.center,
              wrapCrossAxisAlignment: WrapCrossAlignment.center,
              wrapSpacing: 20,
              backgroundColor: Colors.white),
          onApplyButtonClick: (list) {
            // Se hace algo con la lista
            Navigator.pushNamed(context, '/Loginpage');
          },
          choiceChipLabel: (item) {
            return item!.name;
          },
          validateSelectedItem: (list, val) {
            return list!.contains(val);
          },
          onItemSearch: (genre, query) {
            return genre.name!.toLowerCase().contains(query.toLowerCase());
          },
        ),
      ),
    );
  }
}
