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
    final image = user.photoURL ??
        "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg";
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
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Nueva publicación'),
            onTap: () {
              Navigator.pushNamed(context, "/new_post");
            },
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
