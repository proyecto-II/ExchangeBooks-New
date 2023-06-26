class Chat {
  String? id;
  List<String>? members;
  String? lastMessage;
  String? lastMessageDate;
  String? nameChat;

  Chat(
      {this.id,
      this.members,
      this.lastMessage,
      this.lastMessageDate,
      this.nameChat});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['members'] != null) {
      members = List<String>.from(json['members']);
    }
    lastMessage = json['lastMessage'];
    lastMessageDate = json['lastMessageDate'];
    nameChat = json['nameChat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['members'] = members?.toList();
    data['lastMessage'] = lastMessage;
    data['nameChat'] = nameChat;
    data['lastMessageDate'] = lastMessageDate;
    return data;
  }
}
