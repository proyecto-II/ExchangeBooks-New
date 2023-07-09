import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/book.dart';
import '../../../services/user_service.dart';
import '../../posts/user_postview.dart';

class RecordPosts extends StatefulWidget {
  const RecordPosts({super.key, required this.userId});
  final String userId;
  @override
  // ignore: library_private_types_in_public_api
  _RecordPosts createState() => _RecordPosts();
}

class _RecordPosts extends State<RecordPosts> {
  List<Book> posts = [];
  UserService userService = UserService();

  @override
  void initState() {
    getPosts(widget.userId);
    super.initState();
  }

  Future<List<Book>> getPosts(String userId) async {
    posts = await userService.getPostByUser(userId);
    setState(() {});
    return posts;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPostPage(
                    idBook: posts.elementAt(index).id!,
                  ),
                ),
              );
            },
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
                            posts.elementAt(index).images!.first.toString(),
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(25),
                        Text(
                          posts.elementAt(index).title!,
                          style: const TextStyle(
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
}
