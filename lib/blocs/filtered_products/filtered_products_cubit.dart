import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

part 'filtered_products_state.dart';

class FilteredProductsCubit extends Cubit<FilteredProductsState> {
  final List<Product> initialProducts;

  FilteredProductsCubit({
    required this.initialProducts,
  }) : super(FilteredProductsState(filteredProducts: initialProducts));

  void setFilteredProducts(Filter filter, List<Product> products, String? searchTerm) {
    List<Product> _filteredProducts;

    switch (filter) {
      case Filter.all:
        _filteredProducts = products;
        break;
      case Filter.food:
        _filteredProducts =
            products.where((Product product) => product.category == 'food').toList();
        break;
      case Filter.accessories:
        _filteredProducts =
            products.where((Product product) => product.category == 'accessories').toList();
        break;
      case Filter.perro:
        _filteredProducts = products.where((Product product) => product.animal == 'dog').toList();
        break;
      case Filter.gato:
        _filteredProducts = products.where((Product product) => product.animal == 'cat').toList();
        break;
      case Filter.purina:
        _filteredProducts = products.where((Product product) => product.brand == 'Purina').toList();
        break;
      case Filter.royalCanin:
        _filteredProducts =
            products.where((Product product) => product.brand == 'Royal Canin').toList();
        break;
      case Filter.hills:
        _filteredProducts = products.where((Product product) => product.brand == 'Hills').toList();
        break;
      case Filter.pedigree:
        _filteredProducts =
            products.where((Product product) => product.brand == 'Pedigree').toList();
        break;
      case Filter.whiskas:
        _filteredProducts =
            products.where((Product product) => product.brand == 'Whiskas').toList();
        break;
      case Filter.friskies:
        _filteredProducts =
            products.where((Product product) => product.brand == 'Friskies').toList();
        break;
      case Filter.fancyFeast:
        _filteredProducts =
            products.where((Product product) => product.brand == 'Fancy Feast').toList();
        break;
      case Filter.catChow:
        _filteredProducts =
            products.where((Product product) => product.brand == 'CatChow').toList();
        break;
      case Filter.dogChow:
        _filteredProducts =
            products.where((Product product) => product.brand == 'DogChow').toList();
        break;
    }

    if (searchTerm != null && searchTerm.isNotEmpty) {
      _filteredProducts = _filteredProducts
          .where((Product product) =>
              product.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              product.description.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    // emit new state
    emit(state.copyWith(filteredProducts: _filteredProducts));
  }
}
