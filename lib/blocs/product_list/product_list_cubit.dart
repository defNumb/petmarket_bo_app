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

  // Get product list by animal
  Future<void> getProductsByAnimal({required String animal}) async {
    emit(state.copyWith(listStatus: ProductListStatus.loading));
    try {
      final List<Product> products = await productRepository.filterByAnimal(animal: animal);
      emit(
        state.copyWith(
          listStatus: ProductListStatus.loaded,
          productList: products,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: ProductListStatus.error,
          error: e,
        ),
      );
    }
  }

  // Filter by term
  Future<void> searchByAnimalandTerm({required String term, String animal = 'all'}) async {
    emit(state.copyWith(listStatus: ProductListStatus.loading));
    try {
      final List<Product> products = await productRepository.getProductList();
      final List<Product> filteredProducts = products
          .where((element) => animal == 'all' ? true : element.animal == animal)
          .where((element) => element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();
      emit(
        state.copyWith(
          listStatus: ProductListStatus.loaded,
          productList: filteredProducts,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: ProductListStatus.error,
          error: e,
        ),
      );
    }
  }

  // get products by animal and category
  Future<void> getProductsByAnimalAndCategory({
    required String animal,
    required String category,
  }) async {
    emit(state.copyWith(listStatus: ProductListStatus.loading));
    try {
      final List<Product> products = await productRepository.filterByAnimalAndCategory(
        animal: animal,
        category: category,
      );
      emit(
        state.copyWith(
          listStatus: ProductListStatus.loaded,
          productList: products,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: ProductListStatus.error,
          error: e,
        ),
      );
    }
  }
}
