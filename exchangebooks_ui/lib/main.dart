import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/views/auth/login_page.dart';
import 'package:exchangebooks_ui/views/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/landing_page': (context) => const LandingPage(),
          '/login_page': (context) => const LoginPage()
        },
        initialRoute: '/landing_page',
      ),
    );
  }
}
