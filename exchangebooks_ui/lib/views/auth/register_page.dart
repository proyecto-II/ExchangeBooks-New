import 'package:exchangebooks_ui/main.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:exchangebooks_ui/views/auth/genre_page.dart';
import 'package:exchangebooks_ui/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Register createState() => _Register();
}

class _Register extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  final authService = AuthService();

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  bool validateEmail(String email) {
    final pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '¡Hola! Regístrate para empezar',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Urbanist',
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _form(context),
            const Text(
              "ó",
              style: TextStyle(fontSize: 20),
            ),
            const Gap(20),
            //Boton que permite registrarse con cuentas de Google
            _buttonGoogle(context),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya tienes una cuenta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_page');
                    },
                    child: const Text("Inicia Sesión"),
                  )
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
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Ingresa tu nombre',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextFormField(
          controller: lastnameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Ingresa tu apellido',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Ingresa tu correo electronico',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextFormField(
          controller: passConfirmController,
          obscureText: true,
          decoration: InputDecoration(
            hoverColor: Colors.amber,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Confirma tu contraseña',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
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
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text('Siguiente'),
        onPressed: () async {
          if (nameController.text.isEmpty ||
              lastnameController.text.isEmpty ||
              emailController.text.isEmpty ||
              passController.text.isEmpty ||
              passConfirmController.text.isEmpty) {
            _voidAlert(context);
          } else {
            print(validateEmail(emailController.text));
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ));
            bool isRegistered =
                await authService.verifyUser(emailController.text.trim());

            if (isRegistered) {
              print("esta registrado");
              Navigator.pop(context);
              _isRegisterAlert(context);
            } else {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              final user = await provider.emailPasswordRegister(
                nameController.text.trim(),
                lastnameController.text.trim(),
                emailController.text.trim(),
                passController.text.trim(),
              );
              if (user != null) {
                // ignore: use_build_context_synchronously
                await authService.createUser(
                    nameController.text.trim(),
                    lastnameController.text.trim(),
                    emailController.text.trim(),
                    passController.text.trim(),
                    '');
                Navigator.pushNamed(context, '/genre_page');
              } else {
                Navigator.pop(context);
                _badAlert(context);
              }
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
        child: const Text('Registrarse con Google'),
        onPressed: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));

          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          final googleAccount = await provider.googleUser();

          if (googleAccount != null) {
            bool isRegistered =
                await authService.verifyUser(googleAccount.email);
            if (isRegistered) {
              // el usuario ya esta registrado
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            } else {
              await authService.createUser(googleAccount.displayName!, '',
                  googleAccount.email, '', googleAccount.id);
              final user = await provider.googleRegister(googleAccount);

              if (user != null) {
                navigatorKey.currentState!.popUntil((route) => route.isFirst);

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const GenrePage()));
              }
            }
          }
        },
      ),
    );
  }

  void _voidAlert(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return (AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Necesita rellenar todos los campos solicitados',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        ));
      },
    );
  }

  void _badAlert(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return (AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Email ingresado no es valido',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        ));
      },
    );
  }

  void _isRegisterAlert(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return (AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'El usuario ya esta registrado',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        ));
      },
    );
  }
}
