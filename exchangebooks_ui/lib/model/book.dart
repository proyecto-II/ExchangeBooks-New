import 'package:exchangebooks_ui/model/genre.dart';

class Book {
  String? _id;
  String? title;
  String? author;
  String? description;
  List<Genre>? genres;
  String? type;
  List<String>? images;

  Book(this._id, this.title, this.author, this.description, this.genres,
      this.type, this.images);

  Book.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _id;
    data['title'] = title;
    data['author'] = author;
    data['description'] = description;
    data['genres'] = genres?.toList();
    data['type'] = type;
    data['images'] = images?.toList();
    return data;
  }
}
