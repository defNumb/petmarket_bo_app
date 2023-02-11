import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brand extends Equatable {
  final String name;
  final String image;
  Brand({
    required this.name,
    required this.image,
  });

  // initial brand
  factory Brand.initial() {
    return Brand(
      name: '',
      image: '',
    );
  }
  // from doc
  factory Brand.fromJson(DocumentSnapshot doc) {
    return Brand(
      name: doc.id,
      image: doc['image'],
    );
  }

  @override
  List<Object> get props => [name, image];

  @override
  bool get stringify => true;

  Brand copyWith({
    String? name,
    String? image,
  }) {
    return Brand(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }
}
