import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/provider/search_provider.dart';
import 'package:exchangebooks_ui/services/book_service.dart';
import 'package:exchangebooks_ui/services/genre_service.dart';
import 'package:exchangebooks_ui/views/search/widgets/search_list.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../model/genre.dart';
import '../../widgets/drawer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  TextEditingController? searchcontroller;
  String book = "Todos";
  String category = "";
  List<Genre>? selectedGenreList = [];
  List<Genre> genreList = [];

  @override
  void initState() {
    searchcontroller = TextEditingController();
    getGenres();
    super.initState();
  }

  Future<void> getGenres() async {
    List<Genre> genres = await GenreService().getGenres();
    setState(() {
      genreList = genres;
    });
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
          'EXCHANGEBOOK',
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: const Drawers(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 40,
                  child: TextField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      labelText: "Busqueda",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onEditingComplete: () {
                      book = searchcontroller!.text;
                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      openFilter();
                    },
                    icon: const Icon(Icons.filter_alt))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'Resultados de: $book',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Expanded(
              child: SearchList(prefixFilter: book),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openFilter() async {
    await FilterListDelegate.show<Genre>(
      context: context,
      list: genreList,
      selectedListData: selectedGenreList,
      theme: FilterListDelegateThemeData(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Colors.white,
          selectedColor: Colors.red,
          selectedTileColor: const Color(0xFF649BEC).withOpacity(.5),
          textColor: Colors.blue,
        ),
      ),
      onItemSearch: (genre, query) {
        return genre.name!.toLowerCase().contains(query.toLowerCase());
      },
      tileLabel: (genre) => genre!.name,
      emptySearchChild: const Center(child: Text('No se encontraron generos')),
      enableOnlySingleSelection: false,
      searchFieldHint: 'Buscar genero',
      onApplyButtonClick: (list) {
        // if (list!.isNotEmpty) {
        //   final ids = list.map((item) => item.id).whereType<String>().toList();
        //   if (ids.isNotEmpty) {
        //     filterBooks(ids);
        //   }
        // }
        // setState(() {
        //   selectedGenreList = list;
        // });
      },
    );
  }
}
