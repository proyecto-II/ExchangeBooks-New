import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostService {
  final url = dotenv.env['API_URL_AWS'];

  Future<void> createPost() async {}

  Future<String> postImage(String image) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse("$url/file?folder=books"));
      request.files.add(await http.MultipartFile.fromPath('files', image));
      final response = await request.send();

      if (response.statusCode != 200) {
        return 'Sucedio un error ${response.statusCode}';
      }

      final result = await json.decode(await response.stream.bytesToString());
      return result["location"];
    } catch (error) {
      log(error.toString());
      return 'Error al subir la imagen';
    }
  }
}
