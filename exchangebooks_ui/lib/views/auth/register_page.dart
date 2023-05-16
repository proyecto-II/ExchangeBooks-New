import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

  bool _passwordVisible = false;

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
            GestureDetector(
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(scale: 10, 'assets/img/google_logo.png'),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login_page');
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya tienes una cuenta?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_page');
                      },
                      child: const Text("Inicia Sesión"))
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
        onPressed: () {
          Navigator.pushNamed(context, '/genre_page');
        },
      ),
    );
  }
}
