// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'favorite_list_cubit.dart';

// enum list status
enum FavoriteListStatus { loading, initial, success, error }

class FavoriteListState extends Equatable {
  final List<Favorite> favoriteList;
  final List<Product> favoriteProducts;
  final FavoriteListStatus status;
  final CustomError error;

  FavoriteListState({
    required this.favoriteList,
    required this.status,
    required this.error,
    required this.favoriteProducts,
  });

  // initial state
  factory FavoriteListState.initial() {
    return FavoriteListState(
      favoriteList: [],
      status: FavoriteListStatus.initial,
      error: CustomError(),
      favoriteProducts: [],
    );
  }
  @override
  List<Object> get props => [favoriteList, favoriteProducts, status, error];

  @override
  bool get stringify => true;

  FavoriteListState copyWith({
    List<Favorite>? favoriteList,
    List<Product>? favoriteProducts,
    FavoriteListStatus? status,
    CustomError? error,
  }) {
    return FavoriteListState(
      favoriteList: favoriteList ?? this.favoriteList,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
