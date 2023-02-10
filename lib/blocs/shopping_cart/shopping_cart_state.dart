// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shopping_cart_bloc.dart';

enum ShoppingCartStatus {
  initial,
  loading,
  loaded,
  error,
}

class ShoppingCartState extends Equatable {
  final ShoppingCartStatus cartStatus;
  final List<CartItem> shoppingCart;
  final CustomError error;

  ShoppingCartState({
    required this.cartStatus,
    required this.shoppingCart,
    required this.error,
  });

  // Initial shopping cart
  factory ShoppingCartState.initial() {
    return ShoppingCartState(
      cartStatus: ShoppingCartStatus.initial,
      shoppingCart: [],
      error: CustomError(),
    );
  }
  // Equatable
  @override
  List<Object> get props => [cartStatus, shoppingCart, error];

  // ToString
  @override
  bool get stringify => true;

  // When Hydrated Bloc is implemented, this will be used
  // // toMap
  // Map<String, dynamic> toJson() {
  //   final result = <String, dynamic>{};
  //   result.addAll({'shoppingCart': shoppingCart});
  //   return result;
  // }

  // // fromMap
  // factory ShoppingCartState.fromJson(Map<String, dynamic> json) {
  //   return ShoppingCartState(
  //     cartStatus: ShoppingCartStatus.loaded,
  //     shoppingCart: json['shoppingCart'],
  //   );
  // }

  // CopyWith
  ShoppingCartState copyWith({
    ShoppingCartStatus? cartStatus,
    List<CartItem>? shoppingCart,
    CustomError? error,
  }) {
    return ShoppingCartState(
      cartStatus: cartStatus ?? this.cartStatus,
      shoppingCart: shoppingCart ?? this.shoppingCart,
      error: error ?? this.error,
    );
  }
}
