import 'package:flutter/material.dart';

class LandingWidget extends StatelessWidget {
  const LandingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/landing.jpg'),
                  fit: BoxFit.cover)),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.7],
              colors: [Colors.transparent, Color.fromRGBO(252, 163, 17, 1)],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 14),
                const Text(
                  'Encuentra tu libro aquí.',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  'Ahora podras intercambiar tus libros con el de otras personas.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const Spacer(flex: 2),
                _button(context)
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login_page');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(30, 35, 44, 1),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide.none,
        ),
        elevation: 0,
      ),
      child: const Text('Empezar'),
    );
  }
}
