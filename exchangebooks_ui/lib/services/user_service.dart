import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class UserService {
  final url = 'http://localhost:3000';

  Future<void> updateUser(String name, String username, String password) async {
    try {
      var response = await http.put(
        Uri.parse("$url/api/auth/updateUser"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'name': name, 'username': username, 'password': password}),
      );
      if (response.statusCode != 200) {
        log(response.statusCode.toString());
      }
      var result = jsonDecode(response.body);
      log(result);
    } catch (e) {
      log(e.toString());
    }
  }
}
