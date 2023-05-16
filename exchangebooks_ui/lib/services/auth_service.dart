import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final apiUrl = 'http://localhost:3000';

  Future<void> createUser(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      if (response.statusCode == 201) {
        print('Usuario creado correctamente');
      } else {
        print('error');
      }
    } catch (err) {
      print(err);
    }
  }
}
