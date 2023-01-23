import 'package:flutter/material.dart';

class BannerOne extends StatelessWidget {
  const BannerOne({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              color: Colors.deepPurple[200],
              )
            );
  }
}