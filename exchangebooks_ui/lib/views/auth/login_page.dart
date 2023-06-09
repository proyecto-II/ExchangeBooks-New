import 'dart:developer';

import 'package:exchangebooks_ui/main.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:exchangebooks_ui/views/auth/register_page.dart';
import 'package:exchangebooks_ui/views/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Login createState() => _Login();
}

class _Login extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _passwordVisible = false;
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(20),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '¡Bienvenido! ¡Es bueno verte de nuevo!',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Urbanist',
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                    'Aquí podrás intercambiar tus libros con el de las otras personas')),
            _form(context),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes una cuenta?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_page');
                      },
                      child: const Text("Registrate"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(children: [
      const Gap(10),
      Container(
        padding: const EdgeInsets.fromLTRB(20, 3, 20, 0),
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Ingresa tu correo electronico',
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: TextFormField(
          controller: passController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            hoverColor: Colors.amber,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            labelText: 'Ingresa tu contraseña',
          ),
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          '¿Olvido su contraseña?',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      _button(context),
      _buttonGoogle(context)
    ]);
  }

  Widget _button(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(252, 163, 17, 1),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text('Iniciar Sesión'),
        onPressed: () async {
          print("iniciar sesion");
          //Navigator.pushNamed(context, '/Homepage');
          bool isRegistered =
              await authService.verifyUser(emailController.text.trim());
          print(isRegistered);
          if (isRegistered == false) {
            log("el usuario no esta regitrado");
            // mostrar error al usuario
          } else {
            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ));

            final provider =
                // ignore: use_build_context_synchronously
                Provider.of<GoogleSignInProvider>(context, listen: false);
            final user = await provider.emailPasswordSignIn(
                emailController.text.trim(), passController.text.trim());

            if (user != null) {
              navigatorKey.currentState!.popUntil((route) => route.isFirst);

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LandingPage()));
            }
          }
        },
      ),
    );
  }

  Widget _buttonGoogle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text('Iniciar Sesión con Google'),
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );

          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          final googleAccount = await provider.googleUser();

          if (googleAccount != null) {
            bool isRegistered =
                await authService.verifyUser(googleAccount.email);

            if (isRegistered) {
              final user = await provider.googleLogin(googleAccount);

              if (user != null) {
                navigatorKey.currentState!.popUntil((route) => route.isCurrent);

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LandingPage()));
              }
            } else {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const RegisterPage()));
            }
          }
        },
      ),
    );
  }
}
