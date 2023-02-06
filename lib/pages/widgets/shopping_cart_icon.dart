import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/badges/badges_cubit.dart';

Widget shoppingCartIcon(BuildContext context) {
  return BlocBuilder<BadgesCubit, BadgesState>(
    builder: (context, state) {
      return Badge(
        badgeContent: Text(
          state.badgeAmount.toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/shopping_cart');
          },
          icon: const Icon(Icons.shopping_cart),
          iconSize: 30,
        ),
        position: BadgePosition.bottomEnd(bottom: 0, end: 0),
      );
    },
  );
}
