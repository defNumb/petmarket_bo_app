import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product extends Equatable {
  // Setting properties
  final String id;
  final String name;
  final String description;
  final String category;
  final String subCategory;
  final String brand;
  final String image;
  final List<dynamic> price;
  final int discount;
  final int stock;
  final int rating;
  final List<dynamic> weight;
  final List<dynamic> tags;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.brand,
    required this.image,
    required this.price,
    required this.discount,
    required this.stock,
    required this.rating,
    required this.weight,
    required this.tags,
  });

  // Factory constructor to retrieve information from firebase
  factory Product.fromDoc(DocumentSnapshot productDoc) {
    final productData = productDoc.data() as Map<String, dynamic>?;
    return Product(
      id: productDoc.id,
      name: productData!['name'] ?? '',
      description: productData['description'] ?? '',
      category: productData['category'] ?? '',
      subCategory: productData['subCategory'] ?? '',
      brand: productData['brand'] ?? '',
      image: productData['image'] ?? '',
      price: productData['price'] ?? [],
      discount: productData['discount'] ?? -1,
      stock: productData['stock'] ?? -1,
      rating: productData['rating'] ?? -1,
      tags: productData['tags'] ?? [],
      weight: productData['weight'] ?? [],
    );
  }

  // Factory constructor to set product intially that is not in firestore
  factory Product.initialProduct() {
    return Product(
      id: '',
      name: '',
      description: '',
      category: '',
      subCategory: '',
      brand: '',
      image: '',
      price: [],
      discount: -1,
      stock: -1,
      rating: -1,
      tags: [],
      weight: [],
    );
  }

  // Equatable
  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      category,
      subCategory,
      brand,
      image,
      price,
      discount,
      stock,
      rating,
      weight,
      tags,
    ];
  }

  // ToString
  @override
  bool get stringify => true;

  // CopyWith
  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? subCategory,
    String? brand,
    String? image,
    List<dynamic>? price,
    int? discount,
    int? stock,
    int? rating,
    List<dynamic>? tags,
    List<dynamic>? weight,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      tags: tags ?? this.tags,
      weight: weight ?? this.weight,
    );
  }
}
