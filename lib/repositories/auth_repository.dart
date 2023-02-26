import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../constants/db_constant.dart';
import '../models/custom_error.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  // Generate constructors
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  // Sign up method
  Future<void> signup({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      // Create user in firebase auth
      final fbAuth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;

      // Create user in firestore AFTER user is created in firebase auth
      await usersRef.doc(signedInUser.uid).set({
        'id': signedInUser.uid,
        'name': name,
        'last_name': lastName,
        'email': email,
        'point': 0,
        'rank': 'Bronze',
        'phoneNumber': '',
        'dateJoined': DateTime.now().toString(),
      });
    } on fbAuth.FirebaseAuthException catch (e) {
      // HANDLE ERROR
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  // Sign in method
  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  // anonymous sign in method
  Future<void> anonymousSignin() async {
    try {
      await firebaseAuth.signInAnonymously();
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.anonymousSignin',
      );
    }
  }

  // Sign out method
  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
