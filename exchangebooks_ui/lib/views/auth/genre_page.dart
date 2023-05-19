import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/genre.dart';
import '../../provider/google_sign_in.dart';
import '../../services/auth_service.dart';
import '../../services/genre_service.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Genres createState() => _Genres();
}

class _Genres extends State<GenrePage> {
  List<Genre>? selectedGenreList = [];
  List<Genre> genreList = [];
  final authService = AuthService();

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

  Future<void> putGenres() async {
    final iuser = Provider.of<GoogleSignInProvider>(context, listen: false);
    authService.createGenresUser(iuser.user!.email!, selectedGenreList!);
  }

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
            selectedGenreList = list;
            putGenres();
            Navigator.pushNamed(context, '/landing_page');
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
