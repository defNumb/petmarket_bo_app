import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/product_list/product_list_cubit.dart';
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
        title: const Center(
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
                return Card(
                  color: const Color(0xff068BCA),
                  elevation: 10,
                  child: ListTile(
                    title: Text(
                      productDocument.name,
                      style: const TextStyle(
                        fontFamily: fontType,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: fontColor,
                      ),
                    ),
                    subtitle: Text(
                      productDocument.description,
                      style: const TextStyle(
                        fontFamily: fontType,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: fontColor,
                      ),
                    ),
                    trailing: Text(
                      productDocument.price.toString(),
                      style: const TextStyle(
                        fontFamily: fontType,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: fontColor,
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
