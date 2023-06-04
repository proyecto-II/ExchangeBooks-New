import 'package:exchangebooks_ui/services/post_service.dart';
import 'package:exchangebooks_ui/views/posts/postview.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/book.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SearchList createState() => _SearchList();
}

class _SearchList extends State<SearchList> {
  List<Book> allBooks = [];
  PostService postService = PostService();

  @override
  void initState() {
    getBooks();
    super.initState();
  }

  void getBooks() async {
    allBooks = await postService.getAllPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 270,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: allBooks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostPage(
                          book: allBooks.elementAt(index),
                        )),
              );
            },
            child: SizedBox(
              width: 150,
              child: FittedBox(
                child: Column(
                  children: [
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              allBooks.elementAt(index).images!.first,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allBooks.elementAt(index).title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Gap(10),
                              Text(
                                allBooks.elementAt(index).author!,
                                style: TextStyle(fontSize: 15),
                              ),
                              const Gap(10),
                              Text(
                                'Publicado por: ${allBooks.elementAt(index).type}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Apodo',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
