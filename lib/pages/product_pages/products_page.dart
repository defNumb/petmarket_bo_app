// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/product_filter/product_filter_cubit.dart';
import 'package:petmarket_bo_app/blocs/product_list/product_list_cubit.dart';
import 'package:petmarket_bo_app/blocs/product_search/product_search_cubit.dart';
import 'package:petmarket_bo_app/pages/widgets/shopping_cart_icon.dart';

import '../../blocs/filtered_products/filtered_products_cubit.dart';
import '../../constants/app_constants.dart';
import '../../models/product_model.dart';
import 'product_details.dart';

class ProductsPage extends StatefulWidget {
  static const String routeName = '/products';

  const ProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().getProductList();
  }

  @override
  Widget build(BuildContext context) {
    // Get the filtered products from the cubit
    final products = context.watch<FilteredProductsCubit>().state.filteredProducts;
    return Scaffold(
      backgroundColor: const Color(0xff068BCA),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 134, 223),
        elevation: 15,
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Text(
            'Productos',
            style: TextStyle(
              fontFamily: fontType,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: fontColor,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: IconButton(
            onPressed: () {
              // pop the current page
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
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          // Listen to product list changes
          BlocListener<ProductListCubit, ProductListState>(
            listener: (context, state) {
              context.read<FilteredProductsCubit>().setFilteredProducts(
                  context.read<ProductFilterCubit>().state.filter,
                  state.productList,
                  context.read<ProductSearchCubit>().state.searchTerm);
            },
          ),
          // Listen to product filter changes
          BlocListener<ProductFilterCubit, ProductFilterState>(
            listener: (context, state) {
              context.read<FilteredProductsCubit>().setFilteredProducts(
                    state.filter,
                    context.read<ProductListCubit>().state.productList,
                    context.read<ProductSearchCubit>().state.searchTerm,
                  );
            },
          ),
          // Listen to product search changes
          BlocListener<ProductSearchCubit, ProductSearchState>(
            listener: (context, state) {
              context.read<FilteredProductsCubit>().setFilteredProducts(
                    context.read<ProductFilterCubit>().state.filter,
                    context.read<ProductListCubit>().state.productList,
                    state.searchTerm,
                  );
            },
          ),
        ],
        child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
                thickness: 0,
              );
            },
            itemBuilder: (context, index) {
              // print filter status
              // print search status
              Product? productDocument = products[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    // Navigate to product details page
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        productId: productDocument.id,
                      ),
                    ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Stacks on card
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Image.network(
                                        productDocument.image,
                                        frameBuilder:
                                            (context, child, frame, wasSynchronouslyLoaded) {
                                          return child;
                                        },
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 40,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 20, 65, 0),
                                            child: Text(
                                              "Desde Bs. ${productDocument.price}",
                                              style: const TextStyle(
                                                  fontFamily: "QuickSand",
                                                  color: Color.fromARGB(255, 205, 42, 30),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              width: 150,
                                              height: 200,
                                              child: Text(
                                                productDocument.name,
                                                overflow: TextOverflow.fade,
                                                style: const TextStyle(
                                                  fontFamily: "QuickSand",
                                                  color: Colors.black54,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 20),
                                            child: Text(
                                              " tamaños, 1 sabor",
                                              style: const TextStyle(
                                                  fontFamily: "QuickSand", color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // LIKE HEART
                            // const Positioned(
                            //   right: 20,
                            //   top: 10,
                            //   child: Icon(
                            //     Icons.favorite,
                            //     color: Colors.white,
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
