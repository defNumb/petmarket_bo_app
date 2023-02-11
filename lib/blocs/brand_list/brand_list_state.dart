// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'brand_list_cubit.dart';

enum BrandListStatus {
  initial,
  loading,
  loaded,
  error,
}

class BrandListState extends Equatable {
  final BrandListStatus status;
  final List<Brand> brands;
  final CustomError error;

  const BrandListState({
    this.status = BrandListStatus.initial,
    this.brands = const [],
    required this.error,
  });
  // initial state
  factory BrandListState.initial() {
    return BrandListState(
      status: BrandListStatus.initial,
      brands: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, brands, error];

  BrandListState copyWith({
    BrandListStatus? status,
    List<Brand>? brands,
    CustomError? error,
  }) {
    return BrandListState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
