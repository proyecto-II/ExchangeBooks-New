import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final apiUrl = 'http://localhost:3000';

  Future<void> sendData(String data) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'data': data}),
      );
      if (response.statusCode == 200) {
        print('ok');
      } else {
        print('error');
      }
    } catch (err) {
      print(err);
    }
  }
}
