import 'dart:convert';
import 'package:exchangebooks_ui/model/chat.dart';
import 'package:exchangebooks_ui/provider/google_sign_in.dart';
import 'package:exchangebooks_ui/services/chat.service.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'dart:developer';

/*
* Edit profile view
* @param {} phone
* @return {StatefulWidget} Widget
operation
*/
class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool isLoading = true;
  final chatService = ChatService();
  List<Chat> chats = [];

  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateIsLoading(bool newValue) {
    setState(() {
      isLoading = newValue;
    });
  }

  void updateChats(List<Chat> newChats) {
    setState(() {
      chats = newChats;
    });
  }

  Future<void> fetchChats() async {
    try {
      final userProvider =
          Provider.of<GoogleSignInProvider>(context, listen: false);

      Response response =
          await chatService.getUserChats(userProvider.user!.id!);
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Chat> newChats =
          jsonData.map((data) => Chat.fromJson(data)).toList();
      updateChats(newChats);

      print(chats.length);
    } catch (error) {
      log('Error ocurrido al obtener los chats del usuario: $error');
    } finally {
      updateIsLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(249, 251, 251, 251),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 10,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return Column(
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://cdn.pixabay.com/photo/2016/08/20/05/38/avatar-1606916_640.png"),
                                    ),
                                    title: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              chat.nameChat!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              chat.lastMessage!,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 117, 117, 117),
                                                  fontSize: 12),
                                            )
                                          ],
                                        )),
                                        Text(
                                          chat.lastMessageDate!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 117, 117, 117)),
                                        )
                                      ],
                                    ),
                                  )),
                              Divider(
                                height:
                                    20, // Ajusta la altura del espacio entre elementos
                                thickness: 1, // Ajusta el grosor del Divider
                                color: Color.fromARGB(255, 212, 212,
                                    212), // Ajusta el color del Divider
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
