import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_stock_state.dart';

class ProductStockCubit extends Cubit<ProductStockState> {
  ProductStockCubit() : super(ProductStockInitial());
}
