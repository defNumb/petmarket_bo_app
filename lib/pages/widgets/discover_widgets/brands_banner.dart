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
  // List of 3 brands
  final List<Brand> brands = [
    Brand(
      name: 'Royal Canin',
      image: 'assets/images/roya_canin_logo.png',
    ),
    Brand(
      name: 'Purina',
      image: 'assets/images/ProPlan+Logo.png',
    ),
    Brand(
      name: 'Pedigree',
      image: 'assets/images/pedigree_logo.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 0,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return Container(
              width: 150,
              // brand image
              child: Image.asset(brands[index].image),
            );
          },
        ),
      ),
    );
  }
}
