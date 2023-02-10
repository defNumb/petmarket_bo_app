import 'package:flutter/material.dart';
import 'package:petmarket_bo_app/pages/widgets/shopping_cart_icon.dart';

import '../../constants/app_constants.dart';

class PurchaseHistory extends StatefulWidget {
  // path name
  static const String routeName = '/purchase_history';
  const PurchaseHistory({Key? key}) : super(key: key);

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  // INITIALIZERS FOR STREAMS
  // -------------------------
  //
  // Collection reference to the users favorites

  // Stream of purchases
  //
  // Initializing the stream to display
  @override
  void initState() {
    super.initState();
  }

  // MAIN BODY
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 134, 223),
          elevation: 15,
          title: const Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              'Historial de compra',
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
            )
          ],
        ),
        body: noPurchaseHistory());
  }
}

Widget noPurchaseHistory() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'No tienes compras!',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
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
