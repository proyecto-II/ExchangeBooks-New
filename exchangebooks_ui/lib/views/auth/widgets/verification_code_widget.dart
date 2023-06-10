import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerficationCodeWidget extends StatelessWidget {
  String? email;
  VerficationCodeWidget({super.key, required this.email});

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
                'Código de Verificación',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Tu código de verifcacion ha sido enviado a ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff808d9e),
                          fontWeight: FontWeight.w400,
                          height: 1.5)),
                  TextSpan(
                      text: email,
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff005BE0),
                          fontWeight: FontWeight.w400,
                          height: 1.5)),
                ]),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const SizedBox(
                child: Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
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
                child: const Text('Verificar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
