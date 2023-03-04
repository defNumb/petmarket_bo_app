// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/db_constant.dart';
import '../models/address_model.dart';
import '../models/custom_error.dart';

class AddressRepository {
  final FirebaseFirestore firebaseFirestore;
  AddressRepository({
    required this.firebaseFirestore,
  });

  // Stream of address list
  Stream<List<Address>> get addressListStream => usersRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('addresses')
          .snapshots()
          .map((addressList) {
        return addressList.docs.map((addressDoc) => Address.fromDoc(addressDoc)).toList();
      });

  // add new address
  Future<void> addNewAddress(Address myAddress) async {
    // get current user id
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      final addressDoc = await usersRef.doc(uid).collection('addresses');
      var randomDoc = addressDoc.doc();
      await randomDoc.set({
        'id': randomDoc.id,
        'name': myAddress.name,
        'address': myAddress.address,
        'address2': myAddress.address2,
        'city': myAddress.city,
        'state': myAddress.state,
        'zipCode': myAddress.zipCode,
        'phoneNumber': myAddress.phoneNumber,
      });
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
        plugin: 'flutter_error/server_error.addNewAddress',
      );
    }
  }

  // get address list
  Future<List<Address>> getAddressList() async {
    // get current user id
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      final QuerySnapshot addressList = await usersRef.doc(uid).collection('addresses').get();
      if (addressList.docs.isNotEmpty) {
        final addressListData =
            addressList.docs.map((addressDoc) => Address.fromDoc(addressDoc)).toList();
        return addressListData;
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
        plugin: 'flutter_error/server_error.getAddressList',
      );
    }
  }

  // remove address
  Future<void> removeAddress({required String addressId}) async {
    // get current user id
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await usersRef.doc(uid).collection('addresses').doc(addressId).delete();
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
        plugin: 'flutter_error/server_error.removeAddress',
      );
    }
  }

  // update address
  Future<void> updateAddress(Address myAddress) async {
    // get current user id
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await usersRef.doc(uid).collection('addresses').doc(myAddress.id).update({
        'name': myAddress.name,
        'address': myAddress.address,
        'address2': myAddress.address2,
        'city': myAddress.city,
        'state': myAddress.state,
        'zipCode': myAddress.zipCode,
        'phoneNumber': myAddress.phoneNumber,
      });
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
        plugin: 'flutter_error/server_error.updateAddress',
      );
    }
  }
}
