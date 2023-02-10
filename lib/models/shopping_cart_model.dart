// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ShoppingCart extends Equatable {
  final String id;
  ShoppingCart({
    required this.id,
  });

  // Initial shopping cart
  factory ShoppingCart.initial() {
    return ShoppingCart(
      id: '',
    );
  }

  // Convert a Map into a ShoppingCart.
  factory ShoppingCart.fromJson(Map<String, dynamic> json) {
    return ShoppingCart(
      id: json['id'],
    );
  }

  // Convert a ShoppingCart from a Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  // Get shopping cart from firebase
  factory ShoppingCart.fromDoc(DocumentSnapshot shoppingCartDoc) {
    final shoppingCartData = shoppingCartDoc.data() as Map<String, dynamic>?;
    return ShoppingCart(
      id: shoppingCartData!['id'] ?? '',
    );
  }

  // Set shopping cart to firebase
  Map<String, dynamic> toDoc() {
    return {
      'id': id,
    };
  }

  // Equatable
  @override
  List<Object> get props => [
        id,
      ];

  // ToString
  @override
  bool get stringify => true;
}
