class BookRecomendation {
  String? title;
  String? author;
  String? description;
  String? image;

  BookRecomendation(this.title, this.author, this.description, this.image);

  BookRecomendation.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
