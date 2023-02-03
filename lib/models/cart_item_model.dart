// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double price;

  const CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
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
    );
  }
  //
  Map<dynamic, dynamic>toJson(CartItem cartItem) {
    return <dynamic, dynamic>{
      id: cartItem.id,
      name: cartItem.name,
      image: cartItem.image,
      quantity: cartItem.quantity,
      price: cartItem.price,  
  };
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      image,
      quantity,
      price,
    ];
  }

  @override
  bool get stringify => true;
}