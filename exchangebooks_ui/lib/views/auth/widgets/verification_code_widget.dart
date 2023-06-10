import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class VerficationCodeWidget extends StatefulWidget {
  String? email;
  VerficationCodeWidget({super.key, required this.email});

  @override
  State<VerficationCodeWidget> createState() => _VerficationCodeWidgetState();
}

class _VerficationCodeWidgetState extends State<VerficationCodeWidget> {
  final codeController = TextEditingController();
  final focusNode = FocusNode();

  final authService = AuthService();
  bool isLoading = false;

  void updateIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> validateCode() async {
    updateIsLoading(true);

    final isValid = await authService.verifyCode(codeController.text);
    debugPrint('Code validation: $isValid');

    if (isValid) {
      // go to change password page
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/change_password_page");
    } else {
      // show error
    }

    updateIsLoading(false);
  }

  @override
  void dispose() {
    codeController.dispose();
    focusNode.dispose();
    super.dispose();
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
                      text: widget.email,
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
              SizedBox(
                child: Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  controller: codeController,
                ),
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: validateCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(252, 163, 17, 1),
                  minimumSize: const Size(double.infinity, 52),
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
