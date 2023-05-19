import 'package:exchangebooks_ui/layouts/main_layout.dart';
import 'package:exchangebooks_ui/widgets/landing_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const MainLayout();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error de autenticacion'),
          );
        }
        return const LandingWidget();
      },
    ));
  }
}
