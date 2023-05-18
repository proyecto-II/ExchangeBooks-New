import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class UserService {
  final url = 'http://192.168.4.39:3000';

  Future<void> updateUser(
      String id, String name, String username, String lastname) async {
    try {
      final user = {
        'id': id,
        'name': name,
        'username': username,
        'lastname': lastname
      };
      var response = await http.put(
        Uri.parse("$url/api/auth/updateUser/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user),
      );
      if (response.statusCode != 200) {
        log(response.statusCode.toString());
      }
      var result = jsonDecode(response.body);
      log(result);
    } catch (e) {
      log('Paso por aqui ${e.toString()}');
    }
  }
}
