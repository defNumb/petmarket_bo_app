part of 'product_list_cubit.dart';

enum ProductListStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProductListState extends Equatable {
  final ProductListStatus listStatus;
  final List<Product> productList;
  final CustomError error;

  ProductListState({
    required this.listStatus,
    required this.productList,
    required this.error,
  });

  factory ProductListState.initial() {
    return ProductListState(
      listStatus: ProductListStatus.initial,
      productList: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [listStatus, productList, error];

  @override
  bool get stringify => true;

  ProductListState copyWith({
    ProductListStatus? listStatus,
    List<Product>? productList,
    CustomError? error,
  }) {
    return ProductListState(
      listStatus: listStatus ?? this.listStatus,
      productList: productList ?? this.productList,
      error: error ?? this.error,
    );
  }
}
