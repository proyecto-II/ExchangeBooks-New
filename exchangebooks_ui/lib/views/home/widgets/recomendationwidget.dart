import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Recomendations extends StatefulWidget {
  const Recomendations({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Recomendations createState() => _Recomendations();
}

class _Recomendations extends State<Recomendations> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 390,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
                //Componente agregado ya que sin el SizedBox el texto mueve a los demas componentes
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://ekaresur.cl/cms/wp-content/uploads/2019/04/veronica-uribe-el-libro-de-oro-de-los-cuentos-de-hadas-1.jpg',
                          width: 150,
                          height: 225,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Gap(15),
                      const Text(
                        'El libro de oro de los cuentos de hadas',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Gap(10),
                      const Text(
                        'Verónica Uribe',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
