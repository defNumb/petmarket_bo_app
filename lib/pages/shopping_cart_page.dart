import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_constants.dart';

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
  // init
  @override
  void initState() {
    super.initState();
    // get the cart items
    context.read<ShoppingCartBloc>().add(GetCartTotalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Text(
            'Mi Carrito',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Quicksand",
            ),
          ),
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
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.shoppingCart.length,
            itemBuilder: (context, index) {
              CartItem cartItem = state.shoppingCart[index];
              print(cartItem.weight);
              return Card(
                child: Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Container(
                                  height: 100,
                                  width: 100,
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
                              SizedBox(
                                height: 5,
                              ),
                              // In Stock
                              Padding(
                                padding: const EdgeInsets.only(left: 27.0),
                                child: Text(
                                  cartItem.stock != 0 ? 'En stock' : 'Agotado',
                                  style: TextStyle(
                                    color: cartItem.stock != 0 ? Colors.green : Colors.red,
                                    fontSize: 12,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ),

                              // trash can button
                            ],
                          ),
                          // Text
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name
                              Container(
                                width: 150,
                                child: Text(
                                  cartItem.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Weight
                              Text(
                                cartItem.weight == 0
                                    ? ""
                                    : "Bolsa de ${cartItem.weight.toString()} Kg",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Price
                              Text(
                                '\$${cartItem.price * cartItem.quantity}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 213, 49, 49),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                // dollar sign icon
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // small round circle
                                    Container(
                                      height: 17,
                                      width: 17,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // Promotion text
                                Text(
                                    'Compra 1 y recibe 1 con 50% de descuento con el código: 50%OFF',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: "Quicksand",
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //sized box
                      SizedBox(
                        height: 5,
                      ),
                      // Subscribe
                      Row(
                        children: [
                          //subscribe icon
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(
                              Icons.sync_rounded,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          //  Subscribe text
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              'Suscripción - ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text('Activa tu subscripción y ahorra hasta el 5% en ordenes futuras',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9,
                                fontFamily: "Quicksand",
                              )),
                        ],
                      ),
                      // Quantity dropdown list with options equal to stock quantity
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Cantidad: ',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            // Button to remove quantity
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.blue,
                                size: 14,
                              ),
                              onPressed: () {
                                context.read<ShoppingCartBloc>().add(
                                      RemoveFromCartEvent(
                                        cartItem: cartItem,
                                      ),
                                    );
                              },
                            ),
                            // Quantity
                            Text(
                              cartItem.quantity.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            // Button to add quantity
                            IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.blue,
                                size: 14,
                              ),
                              onPressed: () {
                                context.read<ShoppingCartBloc>().add(
                                      AddToCartEvent(
                                        cartItem: cartItem,
                                      ),
                                    );
                              },
                            ),
                            SizedBox(width: 125),
                            // trash can button to remove cart item
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                onPressed: () {
                                  context.read<ShoppingCartBloc>().add(
                                        RemoveFromCartEvent(
                                          cartItem: cartItem,
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            // round bordered container
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 218, 48),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 75,

              // rounded edges button to go to checkout
              child: TextButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            ' Total: \$${double.parse(state.total.toString()).toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Quicksand",
                            ),
                          ),
                        ),
                        // pagar text
                        Row(
                          children: [
                            Text(
                              'CONTINUAR',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            //sized box
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.shopping_cart_checkout_rounded,
                              color: Colors.black,
                              size: 45,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
