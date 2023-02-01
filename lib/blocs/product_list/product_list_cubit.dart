import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ProductRepository productRepository;
  ProductListCubit({required this.productRepository}) : super(ProductListState.initial());

  // Get product list
  Future<List<Product>> getProductList() async {
    try {
      final List<Product> productList = await productRepository.getProductList();
      emit(
        state.copyWith(
          listStatus: ProductListStatus.loaded,
          productList: productList,
        ),
      );
      return productList;
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: ProductListStatus.error,
          error: e,
        ),
      );
      return [];
    }
  }
}
