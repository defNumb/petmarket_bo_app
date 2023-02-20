// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shopping_cart_bloc.dart';

abstract class ShoppingCartBlocEvent extends Equatable {
  const ShoppingCartBlocEvent();

  @override
  List<Object> get props => [];
}

// GetCartEvent
class GetCartEvent extends ShoppingCartBlocEvent {
  final List<CartItem> cartItems;
  GetCartEvent({
    required this.cartItems,
  });

  @override
  List<Object> get props => [cartItems];
}

// AddToCartEvent

class AddToCartEvent extends ShoppingCartBlocEvent {
  final CartItem cartItem;

  const AddToCartEvent({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

// RemoveFromCartEvent

class RemoveFromCartEvent extends ShoppingCartBlocEvent {
  final CartItem cartItem;

  const RemoveFromCartEvent({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

// GetCartTotalEvent

class GetCartTotalEvent extends ShoppingCartBlocEvent {}
