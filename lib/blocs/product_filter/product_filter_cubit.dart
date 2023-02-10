import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

part 'product_filter_state.dart';

class ProductFilterCubit extends Cubit<ProductFilterState> {
  ProductFilterCubit() : super(ProductFilterState.initial());

  void changeFilter(Filter newfilter) {
    emit(state.copyWith(filter: newfilter));
  }
}
