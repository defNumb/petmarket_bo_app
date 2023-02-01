import 'package:flutter/material.dart';
import '../../product_pages/products_page.dart';

class WidgetOne extends StatefulWidget {
  const WidgetOne({Key? key}) : super(key: key);

  @override
  State<WidgetOne> createState() => _WidgetOneState();
}

class CardCategory {
  final String urlImage;
  final String title;
  final Widget link;

  const CardCategory({required this.urlImage, required this.title, required this.link});
}

class _WidgetOneState extends State<WidgetOne> {
  List<CardCategory> items = [
    const CardCategory(
      urlImage: 'assets/images/testdog1.png',
      title: 'Perros',
      link: ProductsPage(),
    ),
    const CardCategory(
      urlImage: 'assets/images/testcat1.png',
      title: 'Gatos',
      link: Text('Hola'),
    ),
    const CardCategory(
      urlImage: 'assets/images/testparrot1.png',
      title: 'Aves',
      link: Text('Hola'),
    ),
    const CardCategory(
      urlImage: 'assets/images/testrat1.png',
      title: 'Animales Pequeños',
      link: Text('Hola'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  'Descubre por mascota',
                  style: TextStyle(
                    fontFamily: "Marhey",
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.black,
                  ),
                ),
                // Solid text as fill.
                const Text(
                  'Descubre por mascota',
                  style: TextStyle(
                    fontFamily: "Marhey",
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, _) => const SizedBox(
                width: 12,
              ),
              itemBuilder: (context, index) => buildCard(item: items[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCard({
    required CardCategory item,
  }) =>
      // ignore: sized_box_for_whitespace
      Container(
        width: 150,
        height: 150,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return item.link;
                }));
              },
              child: Container(
                height: 130,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(item.urlImage),
                ),
              ),
            ),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
}
