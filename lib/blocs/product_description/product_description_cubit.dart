import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/product_repository.dart';

import '../../models/custom_error.dart';
import '../../models/product_model.dart';

part 'product_description_state.dart';

class ProductDescriptionCubit extends Cubit<ProductDescriptionState> {
  final ProductRepository productRepository;

  ProductDescriptionCubit({required this.productRepository})
      : super(ProductDescriptionState.initial());

  // Get product description
  Future<void> getProductDescription({required String pid}) async {
    emit(state.copyWith(productDescriptionStatus: ProductDescriptionStatus.loading));

    try {
      final Product product = await productRepository.getProductProfile(pid: pid);
      emit(
        state.copyWith(
          productDescriptionStatus: ProductDescriptionStatus.loaded,
          product: product,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          productDescriptionStatus: ProductDescriptionStatus.error,
          error: e,
        ),
      );
    }
  }
}
