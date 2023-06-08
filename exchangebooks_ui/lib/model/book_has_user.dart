import 'package:exchangebooks_ui/model/genre.dart';
import 'package:exchangebooks_ui/model/user.dart';

class BookUser {
  String? id;
  String? title;
  String? author;
  String? description;
  List<Genre>? genres;
  String? type;
  List<String>? images;
  IUser? user;

  BookUser(this.id, this.title, this.author, this.description, this.genres,
      this.type, this.images, this.user);

  BookUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    if (json['genres'] != null) {
      genres = List<Genre>.from(
          json['genres'].map((genreJson) => Genre.fromJson(genreJson)));
    }
    type = json['type'];
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }
    user = json['user'] != null ? IUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['description'] = description;
    data['genres'] = genres?.toList();
    data['type'] = type;
    data['images'] = images?.toList();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
