// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String name;
  final String image;
  late final int quantity;
  final double weight;
  final double price;
  final int stock;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.weight,
    required this.price,
    required this.stock,
  });

  //

  // Convert a CartItem into a Map.
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'],
      price: json['price'],
      weight: json['weight'],
      stock: json['stock'],
    );
  }

  // Initial CartItem
  factory CartItem.initialItem() {
    return CartItem(
      id: '',
      name: '',
      image: '',
      quantity: 0,
      price: 0.0,
      weight: 0.0,
      stock: 0,
    );
  }
  // To convert a CartItem from a Map.
  Map<dynamic, dynamic> toJson(CartItem cartItem) {
    return <dynamic, dynamic>{
      id: cartItem.id,
      name: cartItem.name,
      image: cartItem.image,
      quantity: cartItem.quantity,
      price: cartItem.price,
    };
  }

  // Factory constructor to retrieve information from firebase
  factory CartItem.fromDoc(DocumentSnapshot cartItemDoc) {
    final cartItemData = cartItemDoc.data() as Map<String, dynamic>?;
    return CartItem(
      id: cartItemData!['id'] ?? '',
      name: cartItemData['name'] ?? '',
      image: cartItemData['image'] ?? '',
      quantity: cartItemData['quantity'] ?? 0,
      price: cartItemData['price'].toDouble() ?? 0.0,
      weight: cartItemData['weight'].toDouble() ?? 0.0,
      stock: cartItemData['stock'] ?? 0,
    );
  }

  // Constructor to set information to firebase
  Map<dynamic, dynamic> toDoc(CartItem cartItem, String id) {
    return <dynamic, dynamic>{
      id: id,
      name: cartItem.name,
      image: cartItem.image,
      quantity: cartItem.quantity,
      price: cartItem.price,
      weight: cartItem.weight,
      stock: cartItem.stock,
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      image,
      quantity,
      weight,
      price,
      stock,
    ];
  }

  @override
  bool get stringify => true;
}
