import 'package:exchangebooks_ui/views/search/widgets/search_list.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../provider/genre_list.dart';
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
  List<Genre>? selectedGenreList = [];

  @override
  void initState() {
    searchcontroller = TextEditingController();
    super.initState();
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
      drawer: Drawers(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 200,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 124, 1, 87),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: TextField(
                    controller: searchcontroller,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        book = value;
                      }
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
            Row(
              children: [
                Gap(10),
                Text(
                  'Resultados de: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            SearchList(),
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
      /*suggestionBuilder: (context, user, isSelected) {
        return ListTile(
          title: Text(user.name!),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          selected: isSelected,
        );
      },*/
      onApplyButtonClick: (list) {
        setState(() {
          selectedGenreList = list;
        });
      },
    );
  }
}
