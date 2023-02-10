import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import 'home_page.dart';
import 'signin_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: ((context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(SigninPage.routeName);
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.of(context).pushNamed(HomePage.routeName);
        }
      }),
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
