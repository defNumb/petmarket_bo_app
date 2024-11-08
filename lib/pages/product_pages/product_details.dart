import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/favorite_badge/favorite_badge_cubit.dart';
import '../../blocs/product_description/product_description_cubit.dart';
import '../../blocs/shopping_cart/shopping_cart_bloc.dart';
import '../../constants/app_constants.dart';
import '../../models/cart_item_model.dart';
import '../../models/favorite_model.dart';
import '../../utils/error_dialog.dart';
import '../widgets/shopping_cart_icon.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // Variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? weight;
  // Get product description

  @override
  void initState() {
    super.initState();
    _getProductDescription();
    _checkIfProductIsFavorite();
  }

  void _getProductDescription() async {
    await context.read<ProductDescriptionCubit>().getProductDescription(pid: widget.productId);
  }

  void _checkIfProductIsFavorite() async {
    await context.read<FavoriteBadgeCubit>().checkFavorite(id: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 134, 223),
        elevation: 15,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Text(
            'Detalles del producto',
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
            padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
            child: shoppingCartIcon(context),
          )
        ],
      ),
      body: BlocConsumer<ProductDescriptionCubit, ProductDescriptionState>(
        listener: (context, state) {
          if (state.productDescriptionStatus == ProductDescriptionStatus.error) {
            errorDialog(context, state.error);
          }
          print(state.productDescriptionStatus);
        },
        builder: (context, state) {
          if (state.productDescriptionStatus == ProductDescriptionStatus.initial) {
            return Container();
          } else if (state.productDescriptionStatus == ProductDescriptionStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.productDescriptionStatus == ProductDescriptionStatus.error) {
            return Center(
              child: Text('Oops! try again!'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: ListView(
                children: [
                  // PRODUCT IMAGE
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.network(
                      state.product.image,
                      height: 250,
                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    color: Colors.black87,
                  ),

                  // LIKE BUTTON
                  BlocBuilder<FavoriteBadgeCubit, FavoriteBadgeState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(300, 15, 0, 15),
                        child: FavoriteButton(
                          iconSize: 50,
                          valueChanged: (favorited) async {
                            if (favorited) {
                              await context
                                  .read<FavoriteBadgeCubit>()
                                  .addFavorite(favorite: Favorite(id: widget.productId));
                            } else {
                              await context
                                  .read<FavoriteBadgeCubit>()
                                  .removeFavorite(widget.productId);
                            }
                          },
                          isFavorite: state.favorited,
                        ),
                      );
                    },
                  ),

                  // PRODUCT TITLE
                  Text(
                    state.product.name,
                    style: const TextStyle(
                      fontFamily: fontType,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Marca: ${state.product.brand.toUpperCase()} ",
                    style: const TextStyle(
                      fontFamily: fontType,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // PRODUCT PRICE
                  Text(
                    weight != null
                        ? "Bs. ${state.product.price.toString()}"
                        : "Desde Bs. ${state.product.price.toString()}",
                    style: const TextStyle(
                      fontFamily: fontType,
                      fontSize: 20,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // PRDUCT WEIGHTS
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Peso',
                    style: TextStyle(
                      fontFamily: fontType,
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // SizedBox(
                  //   child: DropdownButton<String>(
                  //     dropdownColor: Colors.white,
                  //     underline: Container(
                  //       height: 3,
                  //       color: Colors.black87, //<-- SEE HERE
                  //     ),
                  //     isExpanded: true,
                  //     hint: const Text("Selecciona el peso"),
                  //     value: weight,
                  //     items: state.product.price.keys
                  //         .map(
                  //           (item) => DropdownMenuItem<String>(
                  //             value: item.toString(),
                  //             child: Center(
                  //               child: Text(
                  //                 item.toString(),
                  //                 textAlign: TextAlign.center,
                  //                 style: const TextStyle(fontSize: 15, color: Colors.black87),
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //     onChanged: (item) {
                  //       setState(
                  //         () {
                  //           weight = item;
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 40,
                  ),
                  // PRODUCT DETAILS
                  const Text(
                    'Descripcion del producto',
                    style: TextStyle(
                        fontFamily: fontType,
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    state.product.description.toString(),
                    style: const TextStyle(
                      fontFamily: fontType,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  // ADD TO CART BUTTON
                  Container(
                    height: 50,
                    color: Colors.yellow,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      onPressed: () {
                        CartItem cartItem = CartItem(
                          id: state.product.id,
                          name: state.product.name,
                          price: state.product.price,
                          quantity: 1,
                          image: state.product.image,
                          weight: state.product.weight,
                          stock: state.product.stock,
                        );
                        print(cartItem);
                        context.read<ShoppingCartBloc>().add(AddToCartEvent(cartItem: cartItem));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Agregar al carrito",
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          Icon(
                            Icons.add_shopping_cart_outlined,
                            size: 30,
                            color: Colors.black87,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
