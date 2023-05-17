import 'dart:convert';
import 'package:exchangebooks_ui/model/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final apiUrl = 'http://192.168.4.21:3000';

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
        print(jsonData['message']);
        return false;
      } else {
        print(jsonData['message']);
        return true;
      }
    } catch (err) {
      print(err);
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
      print(err);
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
}
