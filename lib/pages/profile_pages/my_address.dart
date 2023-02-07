import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class MyAddressPage extends StatefulWidget {
  static String routeName = '/my_address';
  const MyAddressPage({super.key});

  @override
  State<MyAddressPage> createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Center(
          child: const Text(
            'Mis Direcciones',
            style: TextStyle(
              fontFamily: fontType,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: fontColor,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            iconSize: 30,
          ),
        ],
      ),
      // TODO: Integrate with Bloc and Repository
      body: noAddress(),
    );
  }
}

Widget noAddress() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'No tienes ninguna dirección agregada',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Añade una dirección para poder realizar tus pedidos',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Agregar dirección'),
        ),
      ],
    ),
  );
}
