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
  final String cardCvv;
  FormOfPayment({
    required this.id,
    required this.cardName,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardExpirationDate,
    required this.cardCvv,
  });

  // Factory constructor to retrieve information from firebase
  factory FormOfPayment.fromDoc(DocumentSnapshot fopData) {
    return FormOfPayment(
      id: fopData.id,
      cardName: fopData['cardName'] ?? '',
      cardNumber: fopData['cardNumber'] ?? '',
      cardHolderName: fopData['cardHolderName'] ?? '',
      cardExpirationDate: fopData['cardExpirationDate'] ?? '',
      cardCvv: fopData['cardCvv'] ?? '',
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
      'cardCvv': fop.cardCvv,
    };
  }

  @override
  List<Object> get props => [id, cardName, cardNumber, cardHolderName, cardExpirationDate, cardCvv];

  @override
  bool get stringify => true;
}
