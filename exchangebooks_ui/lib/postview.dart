import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'widgets/drawer.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Intercambiar',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        LineAwesomeIcons.facebook_messenger,
                        color: Colors.blue,
                        size: 50,
                      )),
                ],
              ),
              _post(),
              const Gap(20),
              const Text(
                'Descripción',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const Gap(10),
              const SizedBox(
                height: 270,
                child: SingleChildScrollView(
                  child: Text(
                    "Una adolescente retrocede en el tiempo para presenciar las experiencias de su abuela en los campos de internamiento japoneses de la época de la Segunda Guerra Mundial en Displacement, una novela gráfica histórica de Kiku Hughes. Kiku está de vacaciones en San Francisco cuando de repente se ve desplazada al campo de internamiento japonés-estadounidense de la década de 1940 al que su difunta abuela, Ernestina, fue reubicada a la fuerza durante la Segunda Guerra Mundial. Estos desplazamientos siguen ocurriendo hasta que Kiku se encuentra atrapada en el tiempo. Al vivir junto a su joven abuela y otros ciudadanos estadounidenses de origen japonés en campos de internamiento, Kiku recibe la educación que nunca recibió en la clase de historia. Ella es testigo de la vida de los japoneses-estadounidenses a quienes se les negaron sus libertades civiles y sufrieron mucho, pero lograron cultivar la comunidad y cometer actos de resistencia para sobrevivir. Kiku Hughes teje una historia fascinante y agridulce que destaca el impacto intergeneracional y el poder de la memoria.",
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
            ]),
          ),
        ),
      ),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://ekaresur.cl/cms/wp-content/uploads/2019/04/veronica-uribe-el-libro-de-oro-de-los-cuentos-de-hadas-1.jpg',
                  width: 150,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'El libro de oro de los cuentos de hadas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Gap(5),
                      Text(
                        'Verónica Uribe',
                        style: TextStyle(fontSize: 15),
                      ),
                      Gap(10),
                      Text(
                        'Publicado por:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Apodo',
                        style: TextStyle(fontSize: 15),
                      ),
                      Gap(15),
                      Text(
                        'Géneros',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Fantasía, Ciencia Ficción',
                      ),
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
}
