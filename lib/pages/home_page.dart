import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/signup-in-switch/signup_in_switch_cubit.dart';
import 'package:petmarket_bo_app/pages/bottom-app-bar-screens/discover.dart';
import 'package:petmarket_bo_app/pages/bottom-app-bar-screens/menu.dart';
import 'package:petmarket_bo_app/pages/bottom-app-bar-screens/shop.dart';
import 'package:petmarket_bo_app/pages/map_pages/placeholder.dart';
import 'package:petmarket_bo_app/pages/widgets/signup-in-switch.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
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
        extendBody: true,
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
        bottomNavigationBar: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // if user is anonymous, show bottom nav bar with extra bar on top
            if (state.authStatus == AuthStatus.anonymous) {
              return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // container with two buttons

                      Container(
                        height: 40,
                        color: Color.fromARGB(255, 2, 10, 16).withOpacity(0.8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // button to sign in
                            TextButton(
                              onPressed: () {
                                context.read<SignupInSwitchCubit>().switchToSignin();
                                showModalBottomSheet<dynamic>(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: <Widget>[
                                        const SignSwitcher(),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 46, 106, 217),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            // divider
                            const VerticalDivider(
                              color: Color.fromARGB(255, 41, 129, 201),
                              thickness: 1,
                              width: 1,
                            ),
                            // button to sign up
                            TextButton(
                              onPressed: () {
                                context.read<SignupInSwitchCubit>().switchToSignup();
                                showModalBottomSheet<dynamic>(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: <Widget>[
                                        const SignSwitcher(),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 46, 106, 217),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //sizebox

                      BottomNavigationBar(
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
                            context
                                .read<BottomNavBarCubit>()
                                .switchNavBarItem(BottomNavBarItem.discover);
                          } else if (index == 1) {
                            context
                                .read<BottomNavBarCubit>()
                                .switchNavBarItem(BottomNavBarItem.shop);
                          } else if (index == 2) {
                            context
                                .read<BottomNavBarCubit>()
                                .switchNavBarItem(BottomNavBarItem.petfind);
                          } else if (index == 3) {
                            context
                                .read<BottomNavBarCubit>()
                                .switchNavBarItem(BottomNavBarItem.myaccount);
                          } else if (index == 4) {
                            context
                                .read<BottomNavBarCubit>()
                                .switchNavBarItem(BottomNavBarItem.menu);
                          } else {
                            context
                                .read<BottomNavBarCubit>()
                                .switchNavBarItem(BottomNavBarItem.discover);
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
                      ),
                    ],
                  );
                },
              );
            }
            // if user is authenticated show normal bottom nav bar
            return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
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
                      context
                          .read<BottomNavBarCubit>()
                          .switchNavBarItem(BottomNavBarItem.myaccount);
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
            );
          },
        ),
      ),
    );
  }
}
