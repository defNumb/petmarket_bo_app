import 'package:flutter/material.dart';
import 'package:petmarket_bo_app/utils/bottomab_controller.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const BottomNavigationBarController();
  }
}
