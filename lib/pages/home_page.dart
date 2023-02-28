import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/pages/bottom-app-bar-screens/discover.dart';
import 'package:petmarket_bo_app/pages/bottom-app-bar-screens/menu.dart';
import 'package:petmarket_bo_app/pages/bottom-app-bar-screens/shop.dart';
import 'package:petmarket_bo_app/pages/map_pages/placeholder.dart';

import '../blocs/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'bottom-app-bar-screens/profile.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            if (state.navBarItem == BottomNavBarItem.discover) {
              return DiscoverPage();
            } else if (state.navBarItem == BottomNavBarItem.shop) {
              return ShopPage();
            } else if (state.navBarItem == BottomNavBarItem.petfind) {
              return PlaceHolderPage();
            } else if (state.navBarItem == BottomNavBarItem.myaccount) {
              return UserProfile();
            } else if (state.navBarItem == BottomNavBarItem.menu) {
              return MenuPage();
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color.fromARGB(255, 9, 80, 138),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              unselectedFontSize: 12,
              selectedFontSize: 15,
              showUnselectedLabels: false,
              currentIndex: state.navBarItem.index,
              onTap: (int index) {
                if (index == 0) {
                  context.read<BottomNavBarCubit>().switchNavBarItem(BottomNavBarItem.discover);
                } else if (index == 1) {
                  context.read<BottomNavBarCubit>().switchNavBarItem(BottomNavBarItem.shop);
                } else if (index == 2) {
                  context.read<BottomNavBarCubit>().switchNavBarItem(BottomNavBarItem.petfind);
                } else if (index == 3) {
                  context.read<BottomNavBarCubit>().switchNavBarItem(BottomNavBarItem.myaccount);
                } else if (index == 4) {
                  context.read<BottomNavBarCubit>().switchNavBarItem(BottomNavBarItem.menu);
                } else {
                  context.read<BottomNavBarCubit>().switchNavBarItem(BottomNavBarItem.discover);
                }
                ;
              },
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
              ],
            );
          },
        ),
      ),
    );
  }
}
