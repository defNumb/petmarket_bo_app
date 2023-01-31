import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/auth/auth_bloc.dart';
import 'package:petmarket_bo_app/blocs/pet_list/pet_list_cubit.dart';
import 'package:petmarket_bo_app/blocs/pet_profile/pet_profile_cubit.dart';
import 'package:petmarket_bo_app/blocs/profile/profile_cubit.dart';
import 'package:petmarket_bo_app/blocs/signin/signin_cubit.dart';
import 'package:petmarket_bo_app/blocs/signup/signup_cubit.dart';
import 'package:petmarket_bo_app/blocs/signup_pet/signup_pet_cubit.dart';
import 'package:petmarket_bo_app/pages/home_page.dart';
import 'package:petmarket_bo_app/pages/profile_pages/my_pets.dart';
import 'package:petmarket_bo_app/pages/signin_page.dart';
import 'package:petmarket_bo_app/pages/signup_page.dart';
import 'package:petmarket_bo_app/pages/splash_page.dart';
import 'package:petmarket_bo_app/pages/widgets/pet_profile_widgets/add_pet.dart';
import 'package:petmarket_bo_app/repositories/auth_repository.dart';
import 'package:petmarket_bo_app/repositories/pet_repository.dart';
import 'package:petmarket_bo_app/repositories/product_repository.dart';
import 'package:petmarket_bo_app/repositories/profile_repository.dart';
import 'blocs/product_list/product_list_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
              profileRepository: context.read<ProfileRepository>(),
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
          )
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
          },
        ),
      ),
    );
  }
}
