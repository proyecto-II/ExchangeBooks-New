class Message {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  DateTime? timestamp;

  Message({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.timestamp,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    timestamp = DateTime.parse(json['timestamp']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['message'] = message;
    data['timestamp'] = timestamp!.toIso8601String();
    return data;
  }
}
