// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  // Setting properties
  final String id;
  final String name;
  final String lastName;
  final String email;
  final int point;
  final String rank;
  final String phoneNumber;
  final String dateJoined;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.point,
    required this.rank,
    required this.phoneNumber,
    required this.dateJoined,
  });

  // Factory constructor to retrieve information from firebase
  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'],
      lastName: userData['lastName'],
      email: userData['email'],
      point: userData['point'],
      rank: userData['rank'],
      phoneNumber: userData['phoneNumber'],
      dateJoined: userData['dateJoined'],
    );
  }

  // Factory constructor to get user intially that is not in firestore
  factory User.initialUser() {
    return User(
      id: '',
      name: '',
      lastName: '',
      email: '',
      point: -1,
      rank: '',
      phoneNumber: '',
      dateJoined: '',
    );
  }

  // Equatable
  @override
  List<Object> get props {
    return [
      id,
      name,
      lastName,
      email,
      point,
      rank,
      phoneNumber,
      dateJoined,
    ];
  }

  // toString method
  @override
  String toString() {
    return 'User ( id: $id, name: $name, lastName: $lastName, email: $email, point: $point, rank: $rank, phoneNumber: $phoneNumber, dateJoined: $dateJoined)';
  }
}
