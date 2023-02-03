// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:petmarket_bo_app/models/product_model.dart';

class ShoppingCart extends Equatable {
  final Map<String,Product> productId;

  const ShoppingCart({
    required this.productId
  });


  // TODO: Implement fromJson and toJson methods

  @override
  List<Object> get props => [productId];
}
