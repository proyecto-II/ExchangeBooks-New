import 'package:exchangebooks_ui/model/book_has_user.dart';
import 'package:exchangebooks_ui/services/post_service.dart';
import 'package:exchangebooks_ui/views/posts/postview.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key, required this.prefixFilter}) : super(key: key);
  final String? prefixFilter;
  @override
  // ignore: library_private_types_in_public_api
  _SearchList createState() => _SearchList();
}

class _SearchList extends State<SearchList> {
  List<BookUser> allBooks = [];
  List<BookUser> filterBooks = [];
  PostService postService = PostService();

  @override
  void initState() {
    super.initState();
  }

  Future<List<BookUser>> getBooks() async {
    allBooks = await postService.getAllPosts();
    return allBooks;
  }

  Future<List<BookUser>> getFilterBooks() async {
    filterBooks = await postService.getFilterPosts(widget.prefixFilter!);
    return filterBooks;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.prefixFilter == "Todos") {
      return FutureBuilder(
        future: getBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                            idBook: allBooks.elementAt(index).id!,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 100,
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
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Gap(10),
                                FittedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allBooks.elementAt(index).title!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      const Gap(10),
                                      Text(
                                        allBooks.elementAt(index).author!,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const Gap(10),
                                      const Text(
                                        'Publicado por:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        allBooks
                                            .elementAt(index)
                                            .user!
                                            .username!,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return _filterList(context);
    }
  }

  Widget _filterList(BuildContext context) {
    return FutureBuilder(
      future: getFilterBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height - 270,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: filterBooks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostPage(
                                idBook: filterBooks.elementAt(index).id!,
                              )),
                    );
                  },
                  child: SizedBox(
                    width: 100,
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
                                  filterBooks.elementAt(index).images!.first,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(10),
                              FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filterBooks.elementAt(index).title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    const Gap(10),
                                    Text(
                                      filterBooks.elementAt(index).author!,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const Gap(10),
                                    const Text(
                                      'Publicado por:',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      filterBooks
                                          .elementAt(index)
                                          .user!
                                          .username!,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
