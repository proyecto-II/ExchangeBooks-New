import 'package:exchangebooks_ui/views/posts/newpost.dart';
import 'package:exchangebooks_ui/provider/genre_provider.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/views/auth/genre_page.dart';
import 'package:exchangebooks_ui/views/auth/login_page.dart';
import 'package:exchangebooks_ui/views/auth/register_page.dart';
import 'package:exchangebooks_ui/views/landing_page.dart';
import 'package:exchangebooks_ui/views/profile/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'views/posts/postview.dart';
import 'views/profile/editprofile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(create: (contexnt) => GenreProvider())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        routes: {
          '/landing_page': (context) => const LandingPage(),
          '/login_page': (context) => const LoginPage(),
          '/register_page': (context) => const RegisterPage(),
          '/genre_page': (context) => const GenrePage(),
          '/edit_profile': (context) => const EditProfile(),
          '/profile_page': (context) => const ProfilePage(),
          '/new_post': (context) => const NewPostPage(),
        },
        initialRoute: '/landing_page',
      ),
    );
  }
}
