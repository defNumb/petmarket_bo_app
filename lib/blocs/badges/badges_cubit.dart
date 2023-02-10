import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/cart_item_model.dart';
import '../shopping_cart/shopping_cart_bloc.dart';

part 'badges_state.dart';

class BadgesCubit extends Cubit<BadgesState> {
  final ShoppingCartBloc shoppingCartBloc;
  late final StreamSubscription shoppingCartSubscription;

  BadgesCubit({required this.shoppingCartBloc}) : super(BadgesState.initial()) {
    shoppingCartSubscription = shoppingCartBloc.stream.listen((ShoppingCartState cartState) {
      final int totalNumberOfItemsInCart = cartState.shoppingCart
          .fold(0, (int previousValue, CartItem element) => previousValue + element.quantity);

      if (cartState.shoppingCart.isNotEmpty) {
        emit(state.copyWith(
          badgeAmount: totalNumberOfItemsInCart,
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

  @override
  Future<void> close() {
    shoppingCartSubscription.cancel();
    return super.close();
  }
}
