import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:exchangebooks_ui/model/user.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final authService = AuthService();

  IUser? _user;

  IUser? get user => _user;

  void setUser(IUser? user) {
    _user = user;
    notifyListeners();
  }

  Future<IUser?> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      final IUser dbUser = await authService.getUser(user!.email!);
      setUser(dbUser);
      return dbUser;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future<IUser?> emailPasswordSignIn(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      final IUser dbUser = await authService.getUser(email);
      setUser(dbUser);
      return dbUser;
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        print("Usuario incorrecto");
      } else if (err.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  Future<IUser?> emailPasswordRegister(
      String name, String lastname, String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      final IUser dbUser = await authService.getUser(email);
      setUser(dbUser);
      return dbUser;
    } on FirebaseAuthException catch (err) {
      print(err);
      return null;
    }
  }

  Future logoout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
