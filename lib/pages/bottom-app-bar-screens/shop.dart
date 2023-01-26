import 'package:flutter/material.dart';
import 'package:petmarket_bo_app/pages/widgets/shop_widgets/bird_category.dart';
import 'package:petmarket_bo_app/pages/widgets/shop_widgets/cat_category.dart';
import 'package:petmarket_bo_app/pages/widgets/shop_widgets/dog_category.dart';
import 'package:petmarket_bo_app/pages/widgets/shop_widgets/smallpet_category.dart';

import '../../constants/app_constants.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        // AppBar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 26, 134, 223),
            elevation: 15,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/petmarketlogo.png'),
                )),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                  iconSize: 30,
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Busqueda',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // BODY
        body: ListView(
          children: const [
            DogCategory(),
            CatCategory(),
            BirdCategory(),
            SmallPetCategory(),
          ],
        ));
  }
}
