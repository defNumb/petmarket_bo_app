import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/constants/app_constants.dart';

import '../blocs/shopping_cart/shopping_cart_bloc.dart';
import '../models/cart_item_model.dart';
import '../utils/error_dialog.dart';

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
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Text('Mi Carrito'),
        ),
      ),
      body: BlocConsumer<ShoppingCartBloc, ShoppingCartState>(
        listener: (context, state) {
          if (state.cartStatus == ShoppingCartStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.shoppingCart.isEmpty) {
            return Center(
              child: Text(
                'No hay productos en el carrito',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
              itemCount: state.shoppingCart.length,
              itemBuilder: (context, index) {
                CartItem cartItem = state.shoppingCart[index];

                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  // Image
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                        cartItem.image,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  // Text
                                  Column(
                                    children: [
                                      // Name
                                      Flexible(
                                        child: Container(
                                          width: 150,
                                          height: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: Text(
                                              cartItem.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Price
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Precio: \$${cartItem.price * cartItem.quantity}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                                        child: Row(
                                          children: [
                                            // button to remove one item
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                context
                                                    .read<ShoppingCartBloc>()
                                                    .add(RemoveFromCartEvent(cartItem: cartItem));
                                              },
                                            ),
                                            Text(
                                              'Cantidad: ${cartItem.quantity}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // button to add one item
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                context
                                                    .read<ShoppingCartBloc>()
                                                    .add(AddToCartEvent(cartItem: cartItem));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
              });
        },
      ),
    );
  }
}
