// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_products_cubit.dart';

class FilteredProductsState extends Equatable {
  final List<Product> filteredProducts;

  FilteredProductsState({
    required this.filteredProducts,
  });

  // Initial state
  factory FilteredProductsState.initial() {
    return FilteredProductsState(
      filteredProducts: [],
    );
  }

  @override
  List<Object> get props => [filteredProducts];

  @override
  bool get stringify => true;

  FilteredProductsState copyWith({
    List<Product>? filteredProducts,
  }) {
    return FilteredProductsState(
      filteredProducts: filteredProducts ?? this.filteredProducts,
    );
  }
}
