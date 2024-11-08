import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum Filter {
  all,
  food,
  accessories,
  perro,
  gato,
  purina,
  royalCanin,
  hills,
  pedigree,
  whiskas,
  friskies,
  fancyFeast,
  catChow,
  dogChow,
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product extends Equatable {
  // Setting properties
  final String id;
  final String name;
  final String description;
  final String category;
  final String subCategory;
  final String brand;
  final String animal;
  final String image;
  final String size;
  final String color;
  final double price;
  final double weight;
  final int discount;
  final int stock;
  final int rating;
  final List<dynamic> tags;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.brand,
    required this.animal,
    required this.image,
    required this.size,
    required this.color,
    required this.price,
    required this.weight,
    required this.discount,
    required this.stock,
    required this.rating,
    required this.tags,
  });

  // Factory constructor to retrieve information from firebase
  factory Product.fromDoc(DocumentSnapshot productDoc) {
    final Map<String, dynamic>? productData = productDoc.data() as Map<String, dynamic>?;

    return Product(
      id: productDoc.id,
      name: productData!['name'] ?? '',
      description: productData['description'] ?? '',
      category: productData['category'] ?? '',
      subCategory: productData['sub_category'] ?? '',
      animal: productData['animal'] ?? '',
      brand: productData['brand'] ?? '',
      image: productData['image'] ?? '',
      size: productData['size'] ?? '',
      color: productData['color'] ?? '',
      price: productData['price'].toDouble() ?? 0.00,
      weight: productData['weight'].toDouble() ?? 0.00,
      discount: productData['discount'] ?? 0,
      stock: productData['stock'] ?? 0,
      rating: productData['rating'] ?? 0,
      tags: productData['tags'] ?? [],
    );
  }

  // set product to firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'animal': animal,
      'brand': brand,
      'color': color,
      'image': image,
      'size': size,
      'price': price,
      'discount': discount,
      'stock': stock,
      'rating': rating,
      'tags': tags,
    };
  }

  // Factory constructor to set product intially that is not in firestore
  factory Product.initialProduct() {
    return Product(
      id: '',
      name: '',
      description: '',
      category: '',
      subCategory: '',
      animal: '',
      brand: '',
      size: '',
      color: '',
      image: '',
      price: 0.00,
      weight: 0.00,
      discount: 0,
      stock: 0,
      rating: 0,
      tags: [],
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
      animal,
      image,
      size,
      color,
      price,
      weight,
      discount,
      stock,
      rating,
      tags,
    ];
  }

  // ToString
  @override
  bool get stringify => true;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? subCategory,
    String? brand,
    String? animal,
    String? image,
    String? size,
    String? color,
    double? price,
    double? weight,
    int? discount,
    int? stock,
    int? rating,
    List<dynamic>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      brand: brand ?? this.brand,
      animal: animal ?? this.animal,
      image: image ?? this.image,
      size: size ?? this.size,
      color: color ?? this.color,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      tags: tags ?? this.tags,
    );
  }
}
