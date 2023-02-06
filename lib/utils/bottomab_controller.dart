import 'package:flutter/material.dart';
import 'package:petmarket_bo_app/pages/map_pages/placeholder.dart';

import '../pages/bottom-app-bar-screens/discover.dart';
import '../pages/bottom-app-bar-screens/menu.dart';
import '../pages/bottom-app-bar-screens/profile.dart';
import '../pages/bottom-app-bar-screens/shop.dart';

class BottomNavigationBarController extends StatefulWidget {
  const BottomNavigationBarController({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarController> createState() => _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    const DiscoverPage(),
    const ShopPage(),
    const PlaceHolderPage(),
    const UserProfile(),
    const MenuPage(),
  ];

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 9, 80, 138),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          unselectedFontSize: 12,
          selectedFontSize: 15,
          showUnselectedLabels: false,
          onTap: (int index) => setState(() => _selectedIndex = index),
          currentIndex: selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Descubre',
              //backgroundColor: Color.fromARGB(255, 9, 80, 138),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: 'Tienda',
              //backgroundColor: Color.fromARGB(255, 9, 80, 138),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'PetFind',
              //backgroundColor: Color.fromARGB(255, 9, 80, 138),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Mi Cuenta',
              //backgroundColor: Color.fromARGB(255, 9, 80, 138),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
              //backgroundColor: Color.fromARGB(255, 9, 80, 138),
            ),
          ]);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      ),
    );
  }
}
