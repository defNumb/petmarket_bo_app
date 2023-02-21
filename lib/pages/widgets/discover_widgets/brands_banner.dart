// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/brand_list/brand_list_cubit.dart';

import '../../../models/brand_model.dart';

class BrandListWidget extends StatefulWidget {
  const BrandListWidget({super.key});

  @override
  State<BrandListWidget> createState() => _BrandListWidgetState();
}

class _BrandListWidgetState extends State<BrandListWidget> {
  // init state of the cubit using override init
  @override
  void initState() {
    super.initState();
    // init the cubit
    context.read<BrandListCubit>().getBrandList();
  }

  @override
  Widget build(BuildContext context) {
    // return a column with two rows of two buttons each for each of the brands
    final brands = context.watch<BrandListCubit>().state.brands;
    print(brands);
    return BlocBuilder<BrandListCubit, BrandListState>(
      builder: (context, state) {
        if (state.status == BrandListStatus.loaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // texto Descubre nuestras marcas
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Descubre nuestras marcas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBrandButton(brands[6]),
                  _buildBrandButton(brands[7]),
                  _buildBrandButton(brands[4]),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBrandButton(brands[8]),
                  SizedBox(width: 10),
                  _buildBrandButton(brands[9]),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              // ver todas las marcas colored button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/brands');
                },
                child: const Text(
                  'Ver todas las marcas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// This is the button that will be used to display the brand from the brands list
Widget _buildBrandButton(Brand brand) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: () {
      // When the button is pressed, we will navigate to the product list page
      // and pass the brand name as a parameter
      // Navigator.pushNamed(context, '/products', arguments: brand.name);
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Image.network(
            brand.image,
            height: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            brand.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
