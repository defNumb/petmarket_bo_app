// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petmarket_bo_app/models/fop_model.dart';

import '../constants/db_constant.dart';
import '../models/custom_error.dart';

class FopRepository {
  final FirebaseFirestore firebaseFirestore;

  FopRepository({
    required this.firebaseFirestore,
  });

  // Get fop list
  Future<List<FormOfPayment>> getFopList({required String uid}) async {
    try {
      // get current user id
      final QuerySnapshot fopList = await usersRef.doc(uid).collection('fop').get();
      if (fopList.docs.isNotEmpty) {
        final fopListData = fopList.docs.map((fopDoc) => FormOfPayment.fromDoc(fopDoc)).toList();
        return fopListData;
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.getFopList',
      );
    }
  }

  // Get fop profile
  Future<String> getFopProfile({required String uid, required String fopId}) async {
    try {
      final DocumentSnapshot fopDoc = await usersRef.doc(uid).collection('fop').doc(fopId).get();
      if (fopDoc.exists) {
        final currentFop = fopDoc.id;
        return currentFop;
      }
      throw 'Fop not found';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.getFopProfile',
      );
    }
  }

  // add fop
  Future<void> addFop(FormOfPayment formOfPayment) async {
    // get current user id
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final fopDoc = await usersRef.doc(uid).collection('fop');
      var randomId = fopDoc.doc();
      await fopDoc.doc(randomId.id).set(
        {
          'fopId': randomId.id,
          'cardName': formOfPayment.cardName,
          'cardNumber': formOfPayment.cardNumber,
          'cardExpirationDate': formOfPayment.cardExpirationDate,
          'cardCcv': formOfPayment.cardCcv,
          'cardType': formOfPayment.cardType.toString(),
        },
      );
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.addFop',
      );
    }
  }

  // delete fop
  Future<void> deleteFop(String fopId) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await usersRef.doc(uid).collection('fop').doc(fopId).delete();
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.deleteFop',
      );
    }
  }
}
