import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  static const String routeName = '/shopping_cart';
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Text('Mi Carrito'),
        ),
      ),
    );
  }
}
