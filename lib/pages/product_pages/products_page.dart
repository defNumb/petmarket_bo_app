import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/product_list/product_list_cubit.dart';
import 'package:petmarket_bo_app/pages/product_pages/product_details.dart';
import 'package:petmarket_bo_app/utils/error_dialog.dart';

import '../../constants/app_constants.dart';
import '../../models/product_model.dart';

class ProductsPage extends StatefulWidget {
  static const String routeName = '/products';
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _getProducts() async {
    await context.read<ProductListCubit>().getProductList();
  }

  @override
  Widget build(BuildContext context) {
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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 30,
          ),
        ),
      ),
      body: BlocConsumer<ProductListCubit, ProductListState>(
        listener: (context, state) {
          if (state.listStatus == ProductListStatus.error) {
            errorDialog(context, state.error);
            ;
          }
        },
        builder: (context, state) {
          if (state.listStatus == ProductListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: state.productList.length,
            itemBuilder: (context, index) {
              Product productDocument = state.productList[index];
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
                                      padding: const EdgeInsets.only(left: 20.0),
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
                                        left: 50,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 20, 65, 0),
                                            child: Text(
                                              "Bs.${productDocument.price.first} - Bs.${productDocument.price.last}",
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
                                              "${productDocument.weight.length.toString()} tamaños, 1 sabor",
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
            },
          );
        },
      ),
    );
  }
}
