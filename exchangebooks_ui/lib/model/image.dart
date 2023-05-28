class Image {
  String? _id;
  String? location;

  Image(this._id, this.location);

  Image.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _id;
    return data;
  }
}
