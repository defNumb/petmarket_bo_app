// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/pages/widgets/shop_widgets/dog_products.dart';

import '../../../blocs/product_filter/product_filter_cubit.dart';
import '../../../models/product_model.dart';
import '../../product_pages/products_page.dart';
import '../shop_widgets/cat_products.dart';

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
      link: ProductsPage(),
    ),
    // const CardCategory(
    //   urlImage: 'assets/images/testparrot1.png',
    //   title: 'Aves',
    //   link: Text('Hola'),
    // ),
    // const CardCategory(
    //   urlImage: 'assets/images/testrat1.png',
    //   title: 'Animales Pequeños',
    //   link: Text('Hola'),
    // )
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
                // Text(
                //   'Descubre por mascota',
                //   style: TextStyle(
                //     fontFamily: "Quicksand",
                //     fontSize: 30,
                //     foreground: Paint()
                //       ..style = PaintingStyle.stroke
                //       ..strokeWidth = 2
                //       ..color = Colors.white,
                //   ),
                // ),
                // Solid text as fill.
                const Text(
                  'Descubre por mascota',
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 150,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (context, _) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                itemBuilder: (context, index) => // buildCard(item: items[index]),
                    BuildCard(item: items[index])),
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
                if (item.title == 'Perros') {
                  // Change filter to perro
                  context.watch<ProductFilterCubit>().changeFilter(Filter.perro);
                  // Navigate to products pae using route name
                  Navigator.of(context).pushNamed(ProductsPage.routeName);
                } else if (item.title == 'Gatos') {
                  // get product list
                  context.watch<ProductFilterCubit>().changeFilter(Filter.gato);
                  Navigator.of(context).pushNamed(ProductsPage.routeName);
                }
              },
              child: Container(
                height: 130,
                width: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item.urlImage,
                    fit: BoxFit.fitWidth,
                  ),
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

class BuildCard extends StatefulWidget {
  final CardCategory item;
  const BuildCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.item.title == 'Perros') {
                // navigate to dog products page using regular navigation
                Navigator.of(context).pushNamed(DogProducts.routeName);
              } else if (widget.item.title == 'Gatos') {
                Navigator.of(context).pushNamed(CatProducts.routeName);
              }
            },
            child: Container(
              height: 130,
              width: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black26,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.item.urlImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Text(
            widget.item.title,
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
}
