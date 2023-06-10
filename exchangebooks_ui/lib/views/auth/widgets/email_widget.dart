import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailWidget extends StatefulWidget {
  final Function(String) onEmailChanged;
  const EmailWidget({super.key, required this.onEmailChanged});

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  TextEditingController emailController = TextEditingController();

  final authService = AuthService();

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> sendEmail() async {
    updateIsLoading(true);

    try {
      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.

      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      final complete = SnackBar(
        content: const Text('El correo ha sido enviado!'),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(complete);
    } on FirebaseAuthException catch (err) {
      debugPrint(err.message);
      final error = SnackBar(
        content: Text(err.message!),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    } finally {
      updateIsLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Ingrese email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text:
                          "Se enviara un correo de validacion para poder acceder al cambio de contraseña",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff808d9e),
                          fontWeight: FontWeight.w400,
                          height: 1.5)),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Ingresa tu correo electronico',
                ),
              ),
              const Expanded(child: SizedBox()),
              isLoading
                  ? Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(252, 163, 17, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 3.0),
                        ),
                      ))
                  : ElevatedButton(
                      onPressed: sendEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(252, 163, 17, 1),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide.none,
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Enviar Correo'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
