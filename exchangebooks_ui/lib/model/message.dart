class Message {
  String? id;
  String? sender;
  String? content;
  String? createdAt;
  String? chat;

  Message({this.id, this.sender, this.content, this.createdAt, this.chat});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sender = json['sender'];
    content = json['content'];
    //createdAt = DateTime.parse(json['createdAt']);
    createdAt = json['createdAt'];
    chat = json['chat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['sender'] = sender;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['chat'] = chat;
    return data;
  }
}
