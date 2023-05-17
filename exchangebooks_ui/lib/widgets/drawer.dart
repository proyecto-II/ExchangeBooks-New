import 'package:exchangebooks_ui/model/user.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    final iuser = Provider.of<GoogleSignInProvider>(context);
    final email = user.email ?? "Desconocido";

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(143, 255, 255, 255)),
            accountEmail: Text(
              email,
              style: const TextStyle(color: Colors.black),
            ),
            accountName: Text(
              '${iuser.user != null ? iuser.user!.name! : ""} ${iuser.user != null ? iuser.user!.lastname! : ''}',
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
              if (user.providerData[0].providerId == 'password') {
                FirebaseAuth.instance.signOut();
              } else {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logoout();
              }
            },
          ),
        ],
      ),
    );
  }
}
