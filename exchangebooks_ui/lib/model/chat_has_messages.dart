import 'package:exchangebooks_ui/model/message.dart';

class ChatMessages {
  String? id;
  List<String>? members;
  List<Message>? messages;

  ChatMessages({this.id, this.members});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['members'] != null) {
      members = List<String>.from(json['members']);
    }
    if (json['messages'] != null) {
      messages = List<Message>.from(
          json['messages'].map((message) => Message.fromJson(message)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['members'] = members?.toList();
    data['messages'] = messages?.toList();
    return data;
  }
}
