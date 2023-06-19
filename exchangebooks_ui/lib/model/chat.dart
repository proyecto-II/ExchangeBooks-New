class Chat {
  String? id;
  List<String>? members;

  Chat({
    this.id,
    this.members,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['members'] != null) {
      members = List<String>.from(json['members']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['members'] = members?.toList();
    return data;
  }
}
