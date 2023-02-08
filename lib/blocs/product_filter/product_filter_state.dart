// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_filter_cubit.dart';

class ProductFilterState extends Equatable {
  final Filter filter;
  ProductFilterState({
    required this.filter,
  });

  // initial state
  factory ProductFilterState.initial() {
    return ProductFilterState(
      filter: Filter.all,
    );
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  ProductFilterState copyWith({
    Filter? filter,
  }) {
    return ProductFilterState(
      filter: filter ?? this.filter,
    );
  }
}
