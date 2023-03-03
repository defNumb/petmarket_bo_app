import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmarket_bo_app/blocs/favorite_badge/favorite_badge_cubit.dart';
import 'package:petmarket_bo_app/blocs/signup-in-switch/signup_in_switch_cubit.dart';
import 'package:petmarket_bo_app/repositories/favorite_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/badges/badges_cubit.dart';
import 'blocs/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'blocs/brand_list/brand_list_cubit.dart';
import 'blocs/filtered_products/filtered_products_cubit.dart';
import 'blocs/pet_list/pet_list_cubit.dart';
import 'blocs/pet_profile/pet_profile_cubit.dart';
import 'blocs/product_description/product_description_cubit.dart';
import 'blocs/product_filter/product_filter_cubit.dart';
import 'blocs/product_list/product_list_cubit.dart';
import 'blocs/product_search/product_search_cubit.dart';
import 'blocs/profile/profile_cubit.dart';
import 'blocs/shopping_cart/shopping_cart_bloc.dart';
import 'blocs/signin/signin_cubit.dart';
import 'blocs/signup/signup_cubit.dart';
import 'blocs/signup_pet/signup_pet_cubit.dart';
import 'firebase_options.dart';
import 'pages/bottom-app-bar-screens/shop.dart';
import 'pages/home_page.dart';
import 'pages/product_pages/products_page.dart';
import 'pages/profile_pages/account_options.dart';
import 'pages/profile_pages/favorites.dart';
import 'pages/profile_pages/my_address.dart';
import 'pages/profile_pages/my_pets.dart';
import 'pages/profile_pages/notifications.dart';
import 'pages/profile_pages/payment_methods.dart';
import 'pages/profile_pages/purchase_history.dart';
import 'pages/shopping_cart_page.dart';
import 'pages/signin_page.dart';
import 'pages/signup_page.dart';
import 'pages/splash_page.dart';
import 'pages/widgets/pet_profile_widgets/add_pet.dart';
import 'pages/widgets/shop_widgets/cat_products.dart';
import 'pages/widgets/shop_widgets/dog_products.dart';
import 'repositories/auth_repository.dart';
import 'repositories/brand_repository.dart';
import 'repositories/pet_repository.dart';
import 'repositories/product_repository.dart';
import 'repositories/profile_repository.dart';
import 'repositories/shopping_cart_repository.dart';

void main() async {
  // Dependency Injection
  // Setting up Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setting up HydratedBloc
  // This will help store information in the device
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<PetRepository>(
          create: (context) => PetRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<ShoppingCartRepository>(
          create: (context) => ShoppingCartRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        // brand repository
        RepositoryProvider<BrandRepository>(
          create: (context) => BrandRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<FavoriteRepository>(
          create: (context) => FavoriteRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider<PetProfileCubit>(
            create: (context) => PetProfileCubit(
              petRepository: context.read<PetRepository>(),
            ),
          ),
          BlocProvider<PetListCubit>(
            create: (context) => PetListCubit(
              petRepository: context.read<PetRepository>(),
            ),
          ),
          BlocProvider<SignupPetCubit>(
            create: (context) => SignupPetCubit(
              petRepository: context.read<PetRepository>(),
            ),
          ),
          BlocProvider<ProductListCubit>(
            create: (context) => ProductListCubit(
              productRepository: context.read<ProductRepository>(),
            ),
          ),
          BlocProvider<ProductDescriptionCubit>(
            create: (context) => ProductDescriptionCubit(
              productRepository: context.read<ProductRepository>(),
            ),
          ),
          BlocProvider<ShoppingCartBloc>(
            create: (context) => ShoppingCartBloc(
              cartRepository: context.read<ShoppingCartRepository>(),
              productRepository: context.read<ProductRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
          BlocProvider<BadgesCubit>(
            create: (context) => BadgesCubit(
              shoppingCartBloc: context.read<ShoppingCartBloc>(),
            ),
          ),
          BlocProvider<ProductFilterCubit>(
            create: (context) => ProductFilterCubit(),
          ),
          BlocProvider<ProductSearchCubit>(
            create: (context) => ProductSearchCubit(),
          ),
          BlocProvider<FilteredProductsCubit>(
            create: (context) => FilteredProductsCubit(
              initialProducts: context.read<ProductListCubit>().state.productList,
            ),
          ),
          BlocProvider<BrandListCubit>(
            create: (context) => BrandListCubit(
              brandRepository: context.read<BrandRepository>(),
            ),
          ),
          BlocProvider<BottomNavBarCubit>(
            create: (context) => BottomNavBarCubit(),
          ),
          BlocProvider<SignupInSwitchCubit>(
            create: (context) => SignupInSwitchCubit(),
          ),
          BlocProvider<FavoriteBadgeCubit>(
            create: (context) => FavoriteBadgeCubit(
              favoriteRepository: context.read<FavoriteRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Pet Market App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(),
          routes: {
            SignupPage.routeName: (context) => SignupPage(),
            SigninPage.routeName: (context) => SigninPage(),
            HomePage.routeName: (context) => HomePage(),
            MyPetsScreen.routeName: (context) => MyPetsScreen(),
            RegisterPetScreen.routeName: (context) => RegisterPetScreen(),
            ProductsPage.routeName: (context) => ProductsPage(),
            ShoppingCartPage.routeName: (context) => ShoppingCartPage(),
            PurchaseHistory.routeName: (context) => PurchaseHistory(),
            Favorites.routeName: (context) => Favorites(),
            MyAddressPage.routeName: (context) => MyAddressPage(),
            PaymentMethodPage.routeName: (context) => PaymentMethodPage(),
            AccountOptionsPage.routeName: (context) => AccountOptionsPage(),
            NotificationOptionsPage.routeName: (context) => NotificationOptionsPage(),
            DogProducts.routeName: (context) => DogProducts(),
            CatProducts.routeName: (context) => CatProducts(),
            ShopPage.routeName: (context) => ShopPage(),
          },
        ),
      ),
    );
  }
}
