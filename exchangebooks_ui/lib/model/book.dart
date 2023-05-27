import 'package:exchangebooks_ui/model/genre.dart';

class Book {
  String? id;
  String? title;
  String? author;
  String? description;
  List<Genre>? genres;
  String? type;
  String? image;

  Book(this.id, this.title, this.author, this.description, this.genres,
      this.type, this.image);

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    if (json['genres'] != null) {
      genres = <Genre>[];
      json['genres'].forEach((v) {
        genres!.add(Genre.fromJson(v));
      });
    }
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['description'] = description;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['image'] = image;
    return data;
  }
}
