import 'package:exchangebooks_ui/model/user.dart';
import 'package:exchangebooks_ui/services/chat.service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';
import '../../provider/google_sign_in.dart';
import 'widgets/messageBox.dart';

class MessagesPage extends StatefulWidget {
  final IUser user;
  const MessagesPage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _MessagesView createState() => _MessagesView();
}

class _MessagesView extends State<MessagesPage> {
  final TextEditingController _messageController = TextEditingController();

  List<Message> messageList = [
    Message(
      id: '1',
      sender: '6466eb87505e236447066413',
      content: 'Hola, ¿cómo estás?',
      createdAt: DateTime.now(),
    ),
    Message(
      id: '2',
      sender: '6477eb87505e236447066272',
      content: '¡Hola! Estoy bien, gracias.',
      createdAt: DateTime.now(),
    ),
    Message(
      id: '3',
      sender: '6466eb87505e236447066413',
      content: '¿Qué has estado haciendo?',
      createdAt: DateTime.now(),
    ),
    Message(
      id: '4',
      sender: '6477eb87505e236447066272',
      content: 'Muchas cosas',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    joinChat();
    super.initState();
  }

  void joinChat() {
    ChatService().joinChat('ahsbfhbasbdas');
  }

  void sendMessage() {
    final user = Provider.of<GoogleSignInProvider>(context, listen: false);
    if (_messageController.text.isNotEmpty) {
      Message message = Message(
          content: _messageController.text,
          sender: user.user!.id,
          createdAt: DateTime.now());
      messageList.add(message);
      ChatService().sendMessage(message);
      setState(() {});
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 219, 108, 5),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.user.photoUrl != ""
                    ? widget.user.photoUrl!
                    : "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg",
              ),
            ),
            const Gap(10),
            Text(
              widget.user.username!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messageList(),
          ),
          _messageInput(),
        ],
      ),
    );
  }

  Widget _messageList() {
    return ListView(
      children: messageList.map((message) => _messages(message)).toList(),
    );
  }

  Widget _messages(Message message) {
    final user = Provider.of<GoogleSignInProvider>(context);
    var alignment = message.sender == user.user!.id
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: message.sender == user.user!.id
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            MessageBox(
              message: message.content!,
              color: message.sender == user.user!.id
                  ? Colors.orange[200]!
                  : const Color.fromRGBO(222, 223, 247, 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${message.createdAt!.hour}:${message.createdAt!.minute}',
                style: const TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _messageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                fillColor: Color.fromRGBO(222, 223, 247, 1),
                filled: true,
                hintText: 'Escribe alguna cosa',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}
