import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../widgets/shopping_cart_icon.dart';

class Favorites extends StatefulWidget {
  // path name
  static const String routeName = '/favorites';
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 134, 223),
        elevation: 15,
        title: Center(
          child: Text(
            'Favoritos',
            style: TextStyle(
              fontFamily: fontType,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: fontColor,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 5),
            child: shoppingCartIcon(context),
          ),
        ],
      ),
      body: noFavorites(),
    );
  }
}

Widget noFavorites() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'No tienes favoritos!, Utiliza ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.favorite,
              color: Colors.grey,
            ),
          ],
        ),
        const Text('cuando veas un producto que te gusta en nuestra tienda'),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: TextButton(
            onPressed: () {},
            child: Container(
              height: 50,
              width: 250,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Visita nuestra tienda',
                  style: TextStyle(color: Colors.white, fontFamily: 'Quicksand'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
