import 'package:flutter/material.dart';
import 'widgets/drawer.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewPost createState() => _NewPost();
}

class _NewPost extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Nueva Publicación',
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      drawer: const Drawers(),
      body: const SafeArea(child: Text('Homepage')),
    );
  }
}
