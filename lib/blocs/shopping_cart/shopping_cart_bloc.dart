// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:petmarket_bo_app/models/cart_item_model.dart';
import 'package:petmarket_bo_app/repositories/shopping_cart_repository.dart';

import '../../models/custom_error.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';
import '../auth/auth_bloc.dart';
import '../auth/auth_state.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends HydratedBloc<ShoppingCartBlocEvent, ShoppingCartState> {
  late final StreamSubscription cartSubscription;
  final ShoppingCartRepository cartRepository;
  final ProductRepository productRepository;
  final AuthBloc authBloc;

  ShoppingCartBloc(
      {required this.cartRepository, required this.productRepository, required this.authBloc})
      : super(ShoppingCartState.initial()) {
    // subscribe to the cart stream
    cartSubscription = cartRepository.cartItemStream.listen(
      (cartItem) {
        add(GetCartEvent(cartItems: cartItem));
      },
    );
    // Subscribe to the auth bloc
    authBloc.stream.listen(
      (state) {
        if (state.authStatus == AuthStatus.unauthenticated ||
            state.authStatus == AuthStatus.anonymous) {
          // CANCEL THE SUBSCRIPTION
          cartSubscription.cancel();
        }
      },
    );
    // GetCartEvent
    on<GetCartEvent>(
      (event, emit) {
        emit(state.copyWith(
          cartStatus: ShoppingCartStatus.loaded,
          shoppingCart: event.cartItems,
        ));
      },
    );

    // AddToCartEvent
    on<AddToCartEvent>(
      (event, emit) async {
        Product product = await productRepository.getProductProfile(pid: event.cartItem.id);
        // items from state
        final cartItems = state.shoppingCart;

        cartRepository.addToCart(product);

        // add the new item value to the total
        double total = state.total + product.price;

        // emit the new state
        emit(state.copyWith(shoppingCart: cartItems, total: total));
      },
    );

    // RemoveFromCartEvent
    on<RemoveFromCartEvent>(
      (event, emit) async {
        Product product = await productRepository.getProductProfile(pid: event.cartItem.id);
        // items from state
        final cartItems = state.shoppingCart;
        // check if the cart item already exists
        cartRepository.removeFromCart(product);
        // remove the item value from the total
        double total = state.total - (product.price);
        // emit the new state
        emit(state.copyWith(shoppingCart: cartItems, total: total));
      },
    );

    // GetCartTotalEvent
    on<GetCartTotalEvent>(
      (event, emit) async {
        // items from state
        final cartItems = state.shoppingCart;
        // check if the cart item already exists
        double total = 0;
        for (var item in cartItems) {
          Product product = await productRepository.getProductProfile(pid: item.id);
          total += product.price * item.quantity;
        }
        // emit the new state
        emit(state.copyWith(total: total));
      },
    );
  }

  // This will be used once HydratedBloc is implemented
  @override
  ShoppingCartState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ShoppingCartState state) {
    // TODO: implement toJson
    return null;
  }
}
