import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BooksList createState() => _BooksList();
}

class _BooksList extends State<BooksList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 600,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: 150,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://ekaresur.cl/cms/wp-content/uploads/2019/04/veronica-uribe-el-libro-de-oro-de-los-cuentos-de-hadas-1.jpg',
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Text(
                      'El Libro de Oro',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
