// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductDetail extends Equatable {
  // Setting properties
  final String id;
  final double weight;
  final double price;

  ProductDetail({
    required this.id,
    required this.weight,
    required this.price,
  });

  // Initial product detail
  factory ProductDetail.initial() {
    return ProductDetail(
      id: '',
      weight: 0.0,
      price: 0.0,
    );
  }

  // From Doc
  factory ProductDetail.fromDoc(productDoc) {
    final Map<String, dynamic>? productData = productDoc.data() as Map<String, dynamic>?;
    return ProductDetail(
      id: productDoc.id,
      weight: productData!['weight'].toDouble(),
      price: productData['price'].toDouble(),
    );
  }

  // To Doc
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weight': weight,
      'price': price,
    };
  }

  //  Equatable
  @override
  List<Object> get props => [id, weight, price];
  // To string
  @override
  bool get stringify => true;
  // Copywith
  ProductDetail copyWith({
    String? id,
    double? weight,
    double? price,
  }) {
    return ProductDetail(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      price: price ?? this.price,
    );
  }
}
