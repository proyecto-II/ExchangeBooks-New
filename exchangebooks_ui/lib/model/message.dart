import 'chat.dart';

class Message {
  String? id;
  String? sender;
  String? content;
  Chat? chat;
  DateTime? createdAt;

  Message({
    this.id,
    this.sender,
    this.content,
    this.chat,
    this.createdAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sender = json['sender'];
    content = json['content'];
    chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['sender'] = sender;
    data['content'] = content;
    if (chat != null) {
      data['chat'] = chat!.toJson();
    }
    data['createdAt'] = createdAt!.toIso8601String();
    return data;
  }
}
