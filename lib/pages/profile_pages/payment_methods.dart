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
            onPressed: () {},
            icon: const Icon(Icons.add),
            iconSize: 30,
          ),
        ],
      ),
      body: noFormsOfPayment(),
    );
  }
}

Widget noFormsOfPayment() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'No tienes ningún método de pago agregado',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Añade un método de pago para poder realizar tus pedidos',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
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
    ),
  );
}
