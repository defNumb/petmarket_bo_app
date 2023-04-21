import 'package:badges/badges.dart' as Badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/badges/badges_cubit.dart';
import '../../blocs/signup-in-switch/signup_in_switch_cubit.dart';
import 'signup-in-switch.dart';

Widget shoppingCartIcon(BuildContext context) {
  // pop up function
  void _showDialog() {
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
  }

  return BlocBuilder<BadgesCubit, BadgesState>(
    builder: (context, state) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Badges.Badge(
            badgeContent: Text(
              state.authStatus == AuthStatus.anonymous
                  ? '0'
                  : context.read<BadgesCubit>().state.badgeAmount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                state.authStatus == AuthStatus.anonymous
                    ? _showDialog()
                    : Navigator.pushNamed(context, '/shopping_cart');
              },
              icon: const Icon(Icons.shopping_cart),
              iconSize: 30,
            ),
            position: Badges.BadgePosition.bottomEnd(bottom: 0, end: 0),
          );
        },
      );
    },
  );
}
