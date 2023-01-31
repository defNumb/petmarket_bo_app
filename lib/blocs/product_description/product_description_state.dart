part of 'product_description_cubit.dart';

enum ProductDescriptionStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProductDescriptionState extends Equatable {
  final ProductDescriptionStatus productDescriptionStatus;
  final Product product;
  final CustomError error;
  ProductDescriptionState({
    required this.productDescriptionStatus,
    required this.product,
    required this.error,
  });

  factory ProductDescriptionState.initial() {
    return ProductDescriptionState(
      productDescriptionStatus: ProductDescriptionStatus.initial,
      product: Product.initialProduct(),
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [productDescriptionStatus, product, error];

  @override
  bool get stringify => true;

  ProductDescriptionState copyWith({
    ProductDescriptionStatus? productDescriptionStatus,
    Product? product,
    CustomError? error,
  }) {
    return ProductDescriptionState(
      productDescriptionStatus: productDescriptionStatus ?? this.productDescriptionStatus,
      product: product ?? this.product,
      error: error ?? this.error,
    );
  }
}
