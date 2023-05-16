import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    final iuser = Provider.of<GoogleSignInProvider>(context);
    final name = user.displayName ?? "Desconocido";
    final image = user.photoURL ??
        "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg";

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
          'Perfil',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: const Drawers(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/edit_profile");
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  const Gap(10),
                ],
              ),
              Align(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image),
                ),
              ),
              Text(
                '${iuser.user!.name!} ${iuser.user!.lastname! ?? ''}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(25),
              const Text(
                'Mis Preferencias',
                style: TextStyle(
                  color: Color.fromRGBO(20, 30, 71, 1),
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Publicaciones Realizadas',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const Gap(15),
                  TextButton(onPressed: () {}, child: const Text('Ver todo >'))
                ],
              ),
              //Aqui deberian ir las preferencias del usuario
              //const RecordPosts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _preferences() {
    return ListView();
  }
}
