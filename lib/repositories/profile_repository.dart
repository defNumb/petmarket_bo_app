// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petmarket_bo_app/constants/db_constant.dart';
import 'package:petmarket_bo_app/models/custom_error.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:petmarket_bo_app/models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  ProfileRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();
      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      } else {
        return User.initialUser();
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
        plugin: 'flutter_error/server_error.getProfile',
      );
    }
  }

  // update user info
  Future<void> updateProfile(
    String uid,
    String name,
    String lastName,
    String phoneNumber,
    String email,
  ) async {
    try {
      // check to see if the email is different from the current user
      final fbAuth.User? user = firebaseAuth.currentUser;
      if (user!.email != email) {
        await user.updateEmail(email);
      }
      await usersRef.doc(uid).update({
        'name': name,
        'last_name': lastName,
        'phone': phoneNumber,
        'email': email,
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
        plugin: 'flutter_error/server_error.updateProfile',
      );
    }
  }

  //update user password
  Future<void> updatePassword(fbAuth.AuthCredential credential, String newPassword) async {
    try {
      final fbAuth.UserCredential userCredential =
          await fbAuth.FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
      await userCredential.user!.updatePassword(newPassword);
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
        plugin: 'flutter_error/server_error.updatePassword',
      );
    }
  }
}
