import 'package:flutter/material.dart';
import 'package:petmarket_bo_app/pages/widgets/shopping_cart_icon.dart';

import '../widgets/discover_widgets/banner_one.dart';
import '../widgets/discover_widgets/image_slider.dart';
import '../widgets/discover_widgets/widget_one.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(160, 103, 154, 196),
      // AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 134, 223),
          elevation: 15,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/petmarketlogo.png'),
              )),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
              child: shoppingCartIcon(context),
            )
          ],
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(10),
          //   child: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Container(
          //       height: 38,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border.all(color: Colors.white),
          //         borderRadius: BorderRadius.circular(27),
          //       ),
          //       child: const TextField(
          //         decoration: InputDecoration(
          //           border: InputBorder.none,
          //           hintText: 'Busqueda',
          //           prefixIcon: Icon(Icons.search),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),

      body: ListView(
        children: [
          const SizedBox(height: 10),
          const ImageSlider(),
          const BannerOne(),
          const WidgetOne(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                color: Colors.deepPurple[200],
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                color: Colors.deepPurple[200],
              )),
        ],
      ),
    );
  }
}
