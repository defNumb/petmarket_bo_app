// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_search_cubit.dart';

class ProductSearchState extends Equatable {
  final String searchTerm;
  ProductSearchState({
    required this.searchTerm,
  });

  // product search initial state
  factory ProductSearchState.initial() {
    return ProductSearchState(
      searchTerm: '',
    );
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  ProductSearchState copyWith({
    String? searchTerm,
  }) {
    return ProductSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
