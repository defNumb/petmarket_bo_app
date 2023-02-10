import 'package:flutter/material.dart';

class PlaceHolderPage extends StatelessWidget {
  const PlaceHolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 15, 67, 109),
          // image: DecorationImage(
          //   image: AssetImage('images/wallpaper.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Container(
              height: 150,
              width: 150,
              child: Image.asset(
                'assets/images/petmarketlogo.png',
              ),
            ),
            const Center(
              child: Text(
                'Muy Pronto!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Marhey',
                  fontSize: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
