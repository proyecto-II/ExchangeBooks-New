import 'dart:convert';
import 'dart:developer';
import 'package:exchangebooks_ui/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final url = 'http://localhost:3000';

  Future<void> updateUser(User user) async {
    try {
      var response = await http.put(
        Uri.parse("$url/api/auth/updateUser"),
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
      log(e.toString());
    }
  }
}
