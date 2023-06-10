import 'dart:convert';
import 'package:exchangebooks_ui/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:developer';
import '../model/genre.dart';

class AuthService {
  final apiUrl = dotenv.env['API_URL'];

  Future<bool> verifyUser(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/auth/verify'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
        }),
      );

      final jsonData = json.decode(response.body);
      if (response.statusCode == 404) {
        log(jsonData['message']);
        return false;
      } else {
        log(jsonData['message']);
        return true;
      }
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<void> createUser(String name, String lastname, String email,
      String password, String googleId) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/auth/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'lastname': lastname,
          'email': email,
          'password': password,
          'googleId': googleId
        }),
      );
      final jsonData = json.decode(response.body);
      if (response.statusCode == 201) {
        print(jsonData['message']);
      } else {
        print('error');
      }
    } catch (err) {
      print('Paso por aqui $err');
    }
  }

  Future<IUser> getUser(String email) async {
    final response = await http.get(
      Uri.parse('$apiUrl/api/auth/get-user/$email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final jsonData = json.decode(response.body);
    return IUser.fromJson(jsonData);
  }

  Future<void> createGenresUser(String email, List<Genre> genres) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/genre/user/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': email,
          'genres': genres.map((genre) => genre.toJson()).toList()
        }),
      );
      final jsonData = json.decode(response.body);
      if (response.statusCode == 201) {
        log(jsonData['message']);
      } else {
        log('error');
      }
    } catch (err) {
      log('Paso por aqui $err');
    }
  }

  Future<Response> sendResetPasswordEmail(String email) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api/auth/reset-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    return response;
  }

  Future<bool> verifyCode(String code) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/auth/validate-code/$code'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (err) {
      return false;
    }
  }

  Future<Response> changePassword(String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api/auth/change-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'password': password,
      }),
    );
    return response;
  }
}
