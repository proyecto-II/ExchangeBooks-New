import 'package:exchangebooks_ui/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:exchangebooks_ui/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final authService = AuthService();
  final apiUrl = 'http://192.168.4.39:3000';

  IUser? _user;

  IUser? get user => _user;

  void setUser(IUser? user) {
    _user = user;
    notifyListeners();
  }

  Future<IUser?> googleLogin(GoogleSignInAccount googleUser) async {
    try {
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

  Future<GoogleSignInAccount?> googleUser() async {
    try {
      final googleAccount = await googleSignIn.signIn();
      return googleAccount;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<IUser?> googleRegister(GoogleSignInAccount googleUser) async {
    try {
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

  Future<void> getUser(String email) async {
    final response = await http.get(
      Uri.parse('$apiUrl/api/auth/get-user/$email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final jsonData = json.decode(response.body);
    final IUser dbUser = IUser.fromJson(jsonData);

    setUser(dbUser);
    notifyListeners();
  }
}
