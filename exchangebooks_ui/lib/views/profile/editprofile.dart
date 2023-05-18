import 'package:exchangebooks_ui/model/user.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../provider/genre_list.dart';
import '../../provider/google_sign_in.dart';
import '../../services/user_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditState createState() => _EditState();
}

class _EditState extends State<EditProfile> {
  User user = FirebaseAuth.instance.currentUser!;

  TextEditingController? nameController;
  TextEditingController? usernameController;
  TextEditingController? lastnameController;
  late List<Genre>? selectedGenreList = [];
  final userService = UserService();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    nameController =
        TextEditingController(text: user.displayName ?? 'Desconocido');
    usernameController =
        TextEditingController(text: user.displayName ?? 'Desconocido');
    lastnameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    usernameController?.dispose();
    lastnameController?.dispose();
    super.dispose();
  }

  Future<void> updateUser() async {
    final iuser = Provider.of<GoogleSignInProvider>(context, listen: false);
    await UserService().updateUser(iuser.user!.id!, nameController!.text,
        usernameController!.text, lastnameController!.text);
    iuser.getUser(iuser.user!.email!);
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
              _formUsername(),
              const Gap(10),
              _formpass(),
              const Gap(10),

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
              _preferences(context),
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
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 248, 255, 1),
        labelText: "Nombre",
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _formUsername() {
    return TextFormField(
      controller: usernameController,
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
      controller: lastnameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 248, 255, 1),
        labelText: "Apellido",
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _button() {
    return Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
          updateUser();

          await Future.delayed(
            const Duration(seconds: 2),
          );
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(); //Este cierra el circle indicator
          // ignore: use_build_context_synchronously
          Navigator.of(context)
              .pop(); //Por alguna razon con dos de estos envia de vuelta a la pagina anterior - (Buscar una solucion)
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
    });
  }

  Widget _preferences(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
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
                  borderRadius: BorderRadius.circular(10)),
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
      ),
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
