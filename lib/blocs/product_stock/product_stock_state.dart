part of 'product_stock_cubit.dart';

abstract class ProductStockState extends Equatable {
  const ProductStockState();

  @override
  List<Object> get props => [];
}

class ProductStockInitial extends ProductStockState {}
