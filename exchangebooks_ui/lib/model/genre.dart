class Genre {
  String? id;
  String? name;

  Genre(this.id, this.name);

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    name = json['name'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    return data;
  }
}
