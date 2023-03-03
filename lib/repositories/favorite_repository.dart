// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/db_constant.dart';
import '../models/custom_error.dart';
import '../models/favorite_model.dart';

class FavoriteRepository {
  final FirebaseFirestore firebaseFirestore;
  FavoriteRepository({
    required this.firebaseFirestore,
  });

  // Stream of favorite list
  Stream<List<Favorite>> get favoriteListStream => usersRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .snapshots()
          .map((favoriteList) {
        return favoriteList.docs.map((favoriteDoc) => Favorite.fromDoc(favoriteDoc)).toList();
      });

  // Get favorite list
  Future<List<Favorite>> getFavoriteList({required String uid}) async {
    try {
      final QuerySnapshot favoriteList = await usersRef.doc(uid).collection('favorites').get();
      if (favoriteList.docs.isNotEmpty) {
        final favoriteListData =
            favoriteList.docs.map((favoriteDoc) => Favorite.fromDoc(favoriteDoc)).toList();
        return favoriteListData;
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
        plugin: 'flutter_error/server_error.getFavoriteList',
      );
    }
  }

  // Add favorite
  Future<void> addFavorite({required Favorite favorite}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await usersRef
          .doc(uid)
          .collection('favorites')
          .doc(favorite.id)
          .set(favorite.toDoc(favorite));
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
        plugin: 'flutter_error/server_error.addFavorite',
      );
    }
  }

  // Delete favorite
  Future<void> deleteFavorite({required String fid}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await usersRef.doc(uid).collection('favorites').doc(fid).delete();
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
        plugin: 'flutter_error/server_error.deleteFavorite',
      );
    }
  }

  // Delete all favorite
  Future<void> deleteAllFavorite() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final QuerySnapshot favoriteList = await usersRef.doc(uid).collection('favorites').get();
      if (favoriteList.docs.isNotEmpty) {
        favoriteList.docs.forEach((favoriteDoc) async {
          await usersRef.doc(uid).collection('favorites').doc(favoriteDoc.id).delete();
        });
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
        plugin: 'flutter_error/server_error.deleteAllFavorite',
      );
    }
  }

  // Check if favorite exists
  Future<bool> isFavorite({required String fid}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final DocumentSnapshot favoriteDoc =
          await usersRef.doc(uid).collection('favorites').doc(fid).get();
      if (favoriteDoc.exists) {
        return true;
      } else {
        return false;
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
        plugin: 'flutter_error/server_error.isFavorite',
      );
    }
  }
}
