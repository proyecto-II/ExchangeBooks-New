import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:exchangebooks_ui/views/auth/widgets/email_widget.dart';
import 'package:exchangebooks_ui/views/auth/widgets/verification_code_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPasswordPage> {
  String email = '';

  final authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  void updateEmail(String newEmail) {
    setState(() {
      email = newEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EmailWidget(onEmailChanged: updateEmail);
  }
}
