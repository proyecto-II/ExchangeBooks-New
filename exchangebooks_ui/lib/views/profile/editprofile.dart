import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../provider/genre_list.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditState createState() => _EditState();
}

class _EditState extends State<EditProfile> {
  TextEditingController? nameController;
  TextEditingController? nicknameController;
  TextEditingController? passController;
  TextEditingController? passConfirmController;
  late List<Genre>? selectedGenreList = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    nicknameController?.dispose();
    passController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(249, 251, 251, 251),
        centerTitle: true,
        title: const Text(
          'Editar Perfil',
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            children: [
              _formname(),
              const Gap(10),
              _formNickname(),
              const Gap(10),
              _formpass(),
              const Gap(10),
              _formpassconfirm(),
              const Gap(25),

              const Text(
                "Tus Preferencias",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.bold),
              ),
              const Text("Selecciona 3"),

              ///Aqui tienen que ir los diferentes generos
              const Gap(20),
              _buttonPreferences(),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 75),
                  child: _button()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formname() {
    return TextFormField(
      controller: nameController,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 248, 255, 1),
        labelText: "Nombre",
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _formNickname() {
    return TextFormField(
      controller: nicknameController,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 248, 255, 1),
        labelText: "Apodo",
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _formpass() {
    return TextFormField(
      controller: passController,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 248, 255, 1),
        labelText: "Contraseña",
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _formpassconfirm() {
    return TextFormField(
      controller: passConfirmController,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 248, 255, 1),
        labelText: "Confirmar contraseña",
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _button() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/profile_page');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent[1000],
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: const Text('Actualizar'),
    );
  }

  Widget _buttonPreferences() {
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
