import 'dart:developer';

import 'package:exchangebooks_ui/main.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:exchangebooks_ui/views/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _error = false;
  bool _isLoading = false;
  final authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  void updateError(bool value) {
    setState(() {
      _error = value;
    });
  }

  void updateIsLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Future<void> updatePassword() async {
    updateIsLoading(true);

    if (passwordController.text != repeatPasswordController.text) {
      updateError(true);
    } else {
      // send request
      try {
        final user = _auth.currentUser;
        await user!.updatePassword(passwordController.text);

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, "/login_page");
      } catch (err) {
        debugPrint(err.toString());
      } finally {
        updateIsLoading(false);
      }
    }
    updateIsLoading(false);
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
                'Cambiar contraseña',
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
          ],
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(children: [
      const Gap(10),
      Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: TextFormField(
          controller: passwordController,
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
            labelText: 'Repite tu contraseña',
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: TextFormField(
          controller: repeatPasswordController,
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
            labelText: 'Repite tu contraseña',
          ),
        ),
      ),
      if (_error) // Mostrar el mensaje de error solo si _error es verdadero
        Column(
          children: const [
            Gap(10), // Espacio adicional
            Text(
              "Las contraseñas no coinciden",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      _button(context),
    ]);
  }

  Widget _button(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(252, 163, 17, 1),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: updatePassword,
        child: const Text('Cambiar contraseña'),
      ),
    );
  }
}
