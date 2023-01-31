import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_description_state.dart';

class ProductDescriptionCubit extends Cubit<ProductDescriptionState> {
  ProductDescriptionCubit() : super(ProductDescriptionInitial());
}
