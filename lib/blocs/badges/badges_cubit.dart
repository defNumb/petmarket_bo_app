import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petmarket_bo_app/blocs/shopping_cart/shopping_cart_bloc.dart';

part 'badges_state.dart';

class BadgesCubit extends Cubit<BadgesState> {
  final ShoppingCartBloc shoppingCartBloc;
  late final StreamSubscription shoppingCartSubscription;

  BadgesCubit({required this.shoppingCartBloc}) : super(BadgesState.initial()) {
    shoppingCartSubscription = shoppingCartBloc.stream.listen((ShoppingCartState cartState) {
      if (cartState.shoppingCart.isNotEmpty) {
        emit(state.copyWith(
          badgeAmount: cartState.shoppingCart.length,
          badgesStatus: BadgesStatus.loaded,
        ));
      } else {
        emit(state.copyWith(
          badgeAmount: 0,
          badgesStatus: BadgesStatus.loaded,
        ));
      }
    });
  }
}
