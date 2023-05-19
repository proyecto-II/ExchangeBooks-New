import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    final email = user.email ?? "Desconocido";
    final name = user.displayName ?? "Desconocido";

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(143, 255, 255, 255)),
            accountEmail: Text(
              name,
              style: const TextStyle(color: Colors.black),
            ),
            accountName: Text(
              email,
              style: const TextStyle(color: Colors.black),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color.fromARGB(143, 64, 255, 144),
              child: Text("Apodo",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  )),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logoout();
            },
          ),
        ],
      ),
    );
  }
}
