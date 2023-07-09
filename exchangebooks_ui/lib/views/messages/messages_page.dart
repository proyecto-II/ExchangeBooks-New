import 'package:exchangebooks_ui/manager/socket_manager.dart';
import 'package:exchangebooks_ui/model/chat.dart';
import 'package:exchangebooks_ui/model/message.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/views/chat/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:exchangebooks_ui/model/chat_has_messages.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  final Chat info;
  final ChatMessages chat;
  const MessagesPage({super.key, required this.info, required this.chat});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  SocketManager socketManager = SocketManager();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    //_messages = List.from(widget.chat.messages!);

    socketManager.socket.on("receive-message", (data) {
      final mensaje = Message.fromJson(data);
      updateMessages(mensaje);
    });
  }

  void updateMessages(Message newMessage) {
    setState(() {
      _messages.add(newMessage);
    });
  }

  void sendMessage() {
    final userProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    String contentMessage = _messageController.text;
    if (contentMessage.isNotEmpty) {
      Message newMessage = Message(
          content: contentMessage,
          sender: userProvider.user!.id,
          chat: widget.info.id);
      socketManager.socket
          .emit("send-message", {'message': newMessage.toJson()});
      updateMessages(newMessage);
      _messageController.clear();
    }
  }

  void goBack() {
    socketManager.socket.emit("leave-chat", {'chatId': widget.info.id});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(249, 251, 251, 251),
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: goBack,
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2016/08/20/05/38/avatar-1606916_640.png"),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.info.nameChat!,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.vertical_ellipsis),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];

                      return _message(message);
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: "Escribe tu mensaje"),
                  ),
                ),
                IconButton(
                    onPressed: sendMessage,
                    icon: Icon(LineAwesomeIcons.paper_plane))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _message(Message message) {
    final userProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    print(userProvider.user!.id);
    return Container(
      alignment: message.sender == userProvider.user!.id!
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MessageBox(
              message: message.content!,
              color: message.sender == userProvider.user!.id!
                  ? Colors.blue[300]!
                  : Colors.orange[200]!,
            )
          ],
        ),
      ),
    );
  }
}
