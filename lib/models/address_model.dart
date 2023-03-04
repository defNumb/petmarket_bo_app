import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Address extends Equatable {
  final String id;
  final String name;
  final String address;
  final String address2;
  final String city;
  final String state;
  final String zipCode;
  final String phoneNumber;

  Address({
    required this.id,
    required this.name,
    required this.address,
    required this.address2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phoneNumber,
  });

  // Factory constructor to retrieve information from firebase
  factory Address.fromDoc(DocumentSnapshot addressDoc) {
    return Address(
      id: addressDoc['id'] ?? '',
      name: addressDoc['name'] ?? '',
      address: addressDoc['address'] ?? '',
      address2: addressDoc['address2'] ?? '',
      city: addressDoc['city'] ?? '',
      state: addressDoc['state'] ?? '',
      zipCode: addressDoc['zipCode'] ?? '',
      phoneNumber: addressDoc['phoneNumber'] ?? '',
    );
  }

  // constructor to set information to firebase
  Map<String, dynamic> toDoc(Address myAddress, String id) {
    return <String, dynamic>{
      id: id,
      name: myAddress.name,
      address: myAddress.address,
      address2: myAddress.address2,
      city: myAddress.city,
      state: myAddress.state,
      zipCode: myAddress.zipCode,
      phoneNumber: myAddress.phoneNumber,
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      address,
      address2,
      city,
      state,
      zipCode,
      phoneNumber,
    ];
  }
}
