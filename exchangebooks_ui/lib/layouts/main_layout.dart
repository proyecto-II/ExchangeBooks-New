import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/views/home/home_page.dart';
import 'package:exchangebooks_ui/views/profile/profile_page.dart';
import 'package:exchangebooks_ui/views/search/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> {
  int selectedIndex = 0;
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.getUser(user.email!); // Call the API to fetch user data
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomePage(),
      const SearchPage(),
      const HomePage(),
      const ProfilePage()
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -3), // horizontal, vertical
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.orangeAccent.shade400,
            gap: 6,
            padding: const EdgeInsets.all(16),
            tabBorderRadius: 30, // tab animation curves
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Inicio',
              ),
              GButton(icon: Icons.search, text: 'Buscar'),
              GButton(
                icon: Icons.message_rounded,
                text: 'Chat',
              ),
              GButton(
                icon: Icons.person_2_rounded,
                text: 'Perfil',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
