import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class PaymentMethodPage extends StatefulWidget {
  static String routeName = '/payment_methods';
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Center(
          child: const Text(
            'Métodos de Pago',
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
            onPressed: () {
              Navigator.pushNamed(context, '/add_fop');
            },
            icon: const Icon(Icons.add),
            iconSize: 30,
          ),
        ],
      ),
      body: noFormsOfPayment(context),
    );
  }
}

Widget noFormsOfPayment(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      Center(
        child: const Text(
          'No tienes ningún método de pago agregado',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Añade un método de pago para poder realizar tus pedidos',
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Quicksand',
        ),
      ),
      const SizedBox(height: 20),
      Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_fop');
          },
          child: const Text(
            'Añadir Método de Pago',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: appbarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ],
  );
}
