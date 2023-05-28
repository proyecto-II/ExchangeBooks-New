import 'package:flutter/material.dart';
import 'widgets/drawer.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PostView createState() => _PostView();
}

class _PostView extends State<PostPage> {
  @override
  void initState() {
    super.initState();
  }

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
          'Exchangebook',
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: const Drawers(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Widget _buttonPost() {
    return ElevatedButton(
      onPressed: () async {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent[1000],
        minimumSize: const Size(200, 50),
        side: const BorderSide(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: const Text('Publicar'),
    );
  }
}
