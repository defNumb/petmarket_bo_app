import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/favorite_list/favorite_list_cubit.dart';
import 'package:petmarket_bo_app/blocs/product_list/product_list_cubit.dart';

import '../../blocs/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import '../../blocs/favorite_badge/favorite_badge_cubit.dart';
import '../../constants/app_constants.dart';
import '../../utils/error_dialog.dart';
import '../product_pages/product_details.dart';
import '../widgets/shopping_cart_icon.dart';

class Favorites extends StatefulWidget {
  // path name
  static const String routeName = '/favorites';
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // initialize the cubit
  @override
  void initState() {
    super.initState();
    _getFavoritesList();
  }

  // get the favorites list
  void _getFavoritesList() {
    // get the favorites list
    context.read<FavoriteListCubit>().getFavoriteProducts();
  }

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
      body: BlocConsumer<FavoriteListCubit, FavoriteListState>(
        listener: (context, state) {
          if (state.status == ProductListStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.favoriteProducts.isEmpty) {
            return Column(
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
                    onPressed: () {
                      // change the state of the bottom nav bar
                      context.read<BottomNavBarCubit>().switchNavBarItem(BottomNavBarItem.shop);
                      // navigate to shop page
                      Navigator.of(context).pushNamed('/home');
                    },
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
          }
          return ListView.builder(
            itemCount: state.favoriteProducts.length,
            itemBuilder: (context, index) {
              // return a container with the product info and a button to remove the product from the favorites list
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to product details page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          productId: state.favoriteProducts[index].id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 100,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Image.network(
                            state.favoriteProducts[index].image,
                            height: 75,
                            width: 75,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.favoriteProducts[index].name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                              Text(
                                '\$${state.favoriteProducts[index].price}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                                child: IconButton(
                                  onPressed: () {
                                    // remove the product from the favorites list
                                    context
                                        .read<FavoriteBadgeCubit>()
                                        .removeFavorite(state.favoriteProducts[index].id);
                                    // get the favorites list
                                    _getFavoritesList();
                                  },
                                  icon:
                                      const Icon(Icons.delete_outline_outlined, color: Colors.blue),
                                  iconSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
