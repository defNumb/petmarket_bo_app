import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/product_list/product_list_cubit.dart';
import '../../../models/product_model.dart';
import '../../product_pages/product_details.dart';
import '../../../utils/debounce.dart';

class CatProducts extends StatefulWidget {
  static String routeName = '/cat_products';
  const CatProducts({super.key});

  @override
  State<CatProducts> createState() => _CatProductsState();
}

class _CatProductsState extends State<CatProducts> {
  final Debounce debounce = Debounce(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _getProducts() {
    context.read<ProductListCubit>().getProductsByAnimal(animal: 'cat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gatos'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  hintText: 'Buscar',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                onChanged: (value) {
                  debounce.run(() {
                    context
                        .read<ProductListCubit>()
                        .searchByAnimalandTerm(term: value, animal: 'cat');
                  });
                },
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  // Buttons with filters
                  Expanded(
                    child: BlocBuilder<ProductListCubit, ProductListState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  context.read<ProductListCubit>().getProductsByAnimalAndCategory(
                                        animal: 'cat',
                                        category: 'food',
                                      );
                                },
                                child: const Text(
                                  'Comida',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  context.read<ProductListCubit>().getProductsByAnimalAndCategory(
                                        animal: 'cat',
                                        category: 'accessories',
                                      );
                                },
                                child: const Text(
                                  'Accesorios',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  context.read<ProductListCubit>().getProductsByAnimalAndCategory(
                                        animal: 'cat',
                                        category: 'toys',
                                      );
                                },
                                child: const Text(
                                  'Juguetes',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          return ListView.separated(
              itemCount: state.productList.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                  thickness: 0,
                );
              },
              itemBuilder: (context, index) {
                Product? productDocument = state.productList[index];
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
              });
        },
      ),
    );
  }
}
