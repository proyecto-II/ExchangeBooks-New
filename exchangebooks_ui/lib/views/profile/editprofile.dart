import 'package:exchangebooks_ui/provider/genre_provider.dart';
import 'package:exchangebooks_ui/services/genre_service.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../model/genre.dart';
import '../../provider/google_sign_in.dart';
import '../../services/user_service.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

/*
* Edit profile view
* @param {} phone
* @return {StatefulWidget} Widget
operation
*/
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
  List<Genre>? selectedGenreList = [];
  List<Genre> genreList = [];
  final userService = UserService();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    final iuser = Provider.of<GoogleSignInProvider>(context, listen: false);
    nameController =
        TextEditingController(text: iuser.user!.name ?? 'Desconocido');
    usernameController =
        TextEditingController(text: iuser.user!.username ?? 'Desconocido');
    lastnameController =
        TextEditingController(text: iuser.user!.lastname ?? 'Desconocido');
    getGenres();
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    usernameController?.dispose();
    lastnameController?.dispose();
    super.dispose();
  }

  Future<void> getGenres() async {
    genreList = await GenreService().getGenres();
  }

  Future<void> updateUser() async {
    final iuser = Provider.of<GoogleSignInProvider>(context, listen: false);
    final genresProvider = Provider.of<GenreProvider>(context, listen: false);
    await UserService().updateUser(iuser.user!.id!, nameController!.text,
        usernameController!.text, lastnameController!.text);
    await UserService()
        .updateGenresUser(iuser.user!.email!, selectedGenreList!);
    genresProvider.setGenres(selectedGenreList!);
    iuser.getUser(iuser.user!.email!);
  }

  @override
  Widget build(BuildContext context) {
    final genresProvider = Provider.of<GenreProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(249, 251, 251, 251),
        centerTitle: true,
        elevation: 0,
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
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2016/08/20/05/38/avatar-1606916_1280.png",
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
              const Gap(20),
              _formname(),
              const Gap(12),
              _formUsername(),
              const Gap(12),
              _formlastname(),
              const Gap(12),
              Row(
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
                        openFilterDialog(genresProvider.genres!);
                      },
                      icon: const Icon(LineAwesomeIcons.plus))
                ],
              ),
              _preferences(context),
              const Gap(20),
              const SizedBox(
                height: 80,
              ),
              _button()
            ],
          ),
        ),
      ),
    );
  }

  /*
  * Name input
  * @param {} 
  * @return {TextFormField} Widget
  */
  Widget _formname() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
          focusColor: Colors.orange,
          filled: true,
          fillColor: Color.fromRGBO(243, 248, 255, 1),
          labelText: "Nombre",
          prefixIcon: Icon(LineAwesomeIcons.user),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100))),
    );
  }

  /*
  * Username input
  * @param {} 
  * @return {TextFormField} Widget
  */
  Widget _formUsername() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(243, 248, 255, 1),
          labelText: "Apodo",
          prefixIcon: Icon(LineAwesomeIcons.user_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100))),
    );
  }

  /*
  * Lastname input
  * @param {} 
  * @return {TextFormField} Widget
  */
  Widget _formlastname() {
    return TextFormField(
      controller: lastnameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 248, 255, 1),
        labelText: "Apellido",
        prefixIcon: const Icon(LineAwesomeIcons.user),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  Widget _button() {
    return Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
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
                .pop(); //Por alguna razon con dos de estos envia se vuelta a la pagina anterior - (Buscar una solucion)
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size(double.infinity, 50),
              side: BorderSide.none,
              shape: const StadiumBorder(),
              elevation: 1.2),
          child: const Text('Editar Perfil'),
        ),
      );
    });
  }

  /*
  * User genres
  * @param {BuildContext} context
  * @return {Widget} Widget
  */
  Widget _preferences(BuildContext context) {
    final genresProvider = Provider.of<GenreProvider>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genresProvider.genres!.length,
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
                genresProvider.genres!.elementAt(index).name.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  void openFilterDialog(List<Genre> genresPre) async {
    await FilterListDialog.display<Genre>(
      context,
      listData: genreList,
      selectedListData: genresPre,
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
