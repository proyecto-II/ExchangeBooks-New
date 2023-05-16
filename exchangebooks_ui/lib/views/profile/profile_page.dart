import 'package:exchangebooks_ui/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'widgets/recordpost.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
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
                name,
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
              const Gap(15),
              _preferences(context),
              const Gap(10),
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
              const RecordPosts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _preferences(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.amber[800],
                  borderRadius: BorderRadius.circular(10)),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Fantasia",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
