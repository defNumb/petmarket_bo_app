// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//card type
enum CardType { visa, mastercard, amex, discover, others, invalid }

class FormOfPayment extends Equatable {
  // credit card info
  final String id;
  final String cardName;
  final String cardNumber;
  final String cardHolderName;
  final String cardExpirationDate;
  final String cardCcv;
  final CardType cardType;

  FormOfPayment({
    required this.id,
    required this.cardName,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardExpirationDate,
    required this.cardCcv,
    required this.cardType,
  });

  // Factory constructor to retrieve information from firebase
  factory FormOfPayment.fromDoc(DocumentSnapshot fopData) {
    final fopDoc = fopData.data() as Map<String, dynamic>?;

    return FormOfPayment(
      id: fopDoc!['id'] ?? '',
      cardName: fopDoc['cardName'] ?? '',
      cardNumber: fopDoc['cardNumber'] ?? '',
      cardHolderName: fopDoc['cardHolderName'] ?? '',
      cardExpirationDate: fopDoc['cardExpirationDate'] ?? '',
      cardCcv: fopDoc['cardCcv'] ?? '',
      cardType: CardType.values.firstWhere(
        (e) => e.toString().split('.').last == fopDoc['cardType'],
        orElse: () => CardType.invalid,
      ),
    );
  }

  // constructor to set information to firebase
  Map<String, dynamic> toDoc(FormOfPayment fop) {
    return <String, dynamic>{
      'id': fop.id,
      'cardName': fop.cardName,
      'cardNumber': fop.cardNumber,
      'cardHolderName': fop.cardHolderName,
      'cardExpirationDate': fop.cardExpirationDate,
      'cardCcv': fop.cardCcv,
      'cardType': fop.cardType.toString().split('.').last,
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      cardName,
      cardNumber,
      cardHolderName,
      cardExpirationDate,
      cardCcv,
      cardType,
    ];
  }

  @override
  bool get stringify => true;

  FormOfPayment copyWith({
    String? id,
    String? cardName,
    String? cardNumber,
    String? cardHolderName,
    String? cardExpirationDate,
    String? cardCcv,
    CardType? cardType,
  }) {
    return FormOfPayment(
      id: id ?? this.id,
      cardName: cardName ?? this.cardName,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardExpirationDate: cardExpirationDate ?? this.cardExpirationDate,
      cardCcv: cardCcv ?? this.cardCcv,
      cardType: cardType ?? this.cardType,
    );
  }
}
