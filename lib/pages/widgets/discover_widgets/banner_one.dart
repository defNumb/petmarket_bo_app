import 'package:flutter/material.dart';

class BannerOne extends StatelessWidget {
  const BannerOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 139,
          color: Colors.deepPurple[200],
          child: Image.asset(
            'assets/images/banner_1.jpg',
            fit: BoxFit.contain,
          ),
        ));
  }
}
