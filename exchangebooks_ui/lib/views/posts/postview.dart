import 'dart:convert';
import 'dart:developer';
import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/model/message.dart';
import 'package:exchangebooks_ui/services/post_service.dart';
import 'package:exchangebooks_ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import '../../manager/socket_manager.dart';
import '../../model/chat.dart';
import '../../model/chat_has_messages.dart';
import '../../provider/google_sign_in.dart';
import '../../services/chat.service.dart';
import '../messages/messages_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.bookUser}) : super(key: key);
  final BookUser bookUser;

  @override
  // ignore: library_private_types_in_public_api
  _PostView createState() => _PostView();
}

class _PostView extends State<PostPage> {
  late BookUser book;
  SocketManager socketManager = SocketManager();
  final chatService = ChatService();

  @override
  void initState() {
    book = widget.bookUser;
    super.initState();
  }

  Future<BookUser?> getBook(String idBook) async {
    book = (await PostService().getPostById(idBook))!;
    return book;
  }

  Future<void> fetchChat(String currentId) async {
    try {
      final userProvider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      List<String> members = [currentId, book.user!.id!];
      //Chat chatInfo = Chat(members: members, nameChat: members.first);

      final verifyResponse =
          await chatService.verifyChat(currentId, book.user!.id!);

      final jsonVerify = json.decode(verifyResponse.body);

      if (jsonVerify['verify'] == false) {
        final response = await chatService.createChat(currentId, members);
        final jsonData = json.decode(response.body);

        if (response.statusCode == 200) {
          // crea el chat
          final newChat = Chat.fromJson(jsonData);

          // obtenemos la informacion del chat
          final chatInfoResponse =
              await chatService.getChatInfo(newChat.id!, currentId);

          // obtenemos los mensajes del chat
          final responseMessages =
              await chatService.getChatMessages(newChat.id!);

          if (responseMessages.statusCode == 200 &&
              chatInfoResponse.statusCode == 200) {
            final jsonChatInfoData = json.decode(chatInfoResponse.body);
            final jsonMessagesData = json.decode(responseMessages.body);
            final chatInfo = Chat.fromJson(jsonChatInfoData);
            final chatMessages = ChatMessages.fromJson(jsonMessagesData);
            // join to chat
            socketManager.socket.emit("join-chat", newChat.id);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MessagesPage(info: chatInfo, chat: chatMessages)));
          }
        }
      } else {
        final chatId = jsonVerify['chatId'];
        // obtenemos la informacion del chat
        final chatInfoResponse =
            await chatService.getChatInfo(chatId, currentId);

        // obtenemos los mensajes del chat
        final responseMessages = await chatService.getChatMessages(chatId);

        if (responseMessages.statusCode == 200 &&
            chatInfoResponse.statusCode == 200) {
          final jsonChatInfoData = json.decode(chatInfoResponse.body);
          final jsonMessagesData = json.decode(responseMessages.body);
          final chatInfo = Chat.fromJson(jsonChatInfoData);
          final chatMessages = ChatMessages.fromJson(jsonMessagesData);
          print(chatMessages.messages![0].content);
          // join to chat
          socketManager.socket.emit("join-chat", chatId);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MessagesPage(info: chatInfo, chat: chatMessages)));
        }
      }
    } catch (error) {
      log("Error ocurrido al obtener los mensajes del chat: $error");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iuser = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Exchangebook',
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: const Drawers(),
      body: InteractiveViewer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _post(),
                const Gap(20),
                const Text(
                  'Descripción',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const Gap(10),
                SizedBox(
                  height: 270,
                  child: SingleChildScrollView(
                    child: Text(
                      book.description!,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        ' Otros libros',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ver todo >'))
                    ],
                  ),
                ),
                const Gap(10),
                _postList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: book.user!.id != iuser.user!.id
          ? FloatingActionButton.extended(
              onPressed: () {
                fetchChat(iuser.user!.id!);
              },
              label: const Text('Intercambiar'),
              icon: const Icon(Icons.message),
              backgroundColor: Colors.orange[800],
              splashColor: Colors.purple,
            )
          : null,
    );
  }

  Widget _post() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Gap(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _zoomImage(context);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    book.images!.first,
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        book.author!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Gap(10),
                      const Text(
                        'Publicado por:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book.user!.username!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Gap(15),
                      const Text(
                        'Géneros',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _genres(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genres() {
    return SizedBox(
      width: 200,
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: book.genres!.length,
        itemBuilder: (context, index) {
          return Text('${book.genres!.elementAt(index).name!} ');
        },
      ),
    );
  }

  Widget _postList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
              //Componente agregado ya que sin el SizedBox el texto mueve a los demas componentes
              width: 150,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://ekaresur.cl/cms/wp-content/uploads/2019/04/veronica-uribe-el-libro-de-oro-de-los-cuentos-de-hadas-1.jpg',
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(25),
                        const Text(
                          'El libro de la vida',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ignore: slash_for_doc_comments
  /***
  * Widget que permite hacerle zoom a la imagen del libro
  * @param {BuildContext context} Parametro que es usado para realizar llamadas a distintos widgets u obtener datos del widget anterior.
  * @return Un Dialog con la imagen en la cual se le puede hacer gracias a la libreria PhotoView, la que trabaja con InteractiveViewer para los cambios de tamaño de la imagen
  ***/
  void _zoomImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PhotoView(
                      imageProvider: NetworkImage(book.images!.first),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
