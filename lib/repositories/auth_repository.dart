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
        'emailVerified': false,
        'phoneVerified': false,
        'isSubscribed': false,
        'location': GeoPoint(0, 0),
        'orderNotification': false,
        'promotionNotification': false,
        'postNotification': false,
        'isOnline': false,
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
        plugin: 'flutter_error/server_error.signup',
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
      if (e.code == 'user-not-found') {
        throw CustomError(
          code: e.code,
          message: 'Usuario o Contraseña incorrecta!',
        );
      } else if (e.code == 'wrong-password') {
        throw CustomError(
          code: e.code,
          message: 'Usuario o Contraseña incorrecta!',
        );
      }
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.signin',
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

  // Convert anonymous user to permanent user
  Future<void> convertAnonymousUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      // Get current user
      final fbAuth.User? currentUser = firebaseAuth.currentUser;

      // credential
      final fbAuth.AuthCredential credential = fbAuth.EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      // Create user in firebase auth
      final fbAuth.UserCredential userCredential =
          await currentUser!.linkWithCredential(credential);

      final signedInUser = userCredential.user!;

      // Create user in firestore AFTER user is created in firebase auth
      await usersRef.doc(signedInUser.uid).set(
        {
          'id': signedInUser.uid,
          'name': name,
          'last_name': lastName,
          'email': email,
          'point': 0,
          'rank': 'Bronze',
          'phoneNumber': '',
          'dateJoined': DateTime.now().toString(),
          'emailVerified': false,
          'phoneVerified': false,
          'isSubscribed': false,
          'location': GeoPoint(0, 0),
          'orderNotification': false,
          'promotionNotification': false,
          'postNotification': false,
          'isOnline': false,
        },
      );
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
        plugin: 'flutter_error/server_error.convertAnonymousUser',
      );
    }
  }

  // Sign out method
  Future<void> signout() async {
    await firebaseAuth.signOut();
  }

  // Delete user method
  Future<void> deleteUserAccount(String password) async {
    try {
      // Get current user
      final fbAuth.User? currentUser = firebaseAuth.currentUser;
      // get credential
      final fbAuth.AuthCredential credential = fbAuth.EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: password,
      );

      // re-authenticate user and then delete
      await currentUser.reauthenticateWithCredential(credential).then(
        (value) {
          // Delete user in firestore
          usersRef.doc(value.user!.uid).delete();
          value.user!.delete();
        },
      );
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
        plugin: 'flutter_error/server_error.deleteUserAccount',
      );
    }
  }

  // Update user email
  Future<void> updateEmail(String newEmail, String password) async {
    try {
      // Get current user
      final fbAuth.User? currentUser = firebaseAuth.currentUser;
      // Re-authenticate user and then update email
      await currentUser!
          .reauthenticateWithCredential(
        fbAuth.EmailAuthProvider.credential(
          email: currentUser.email!,
          password: password,
        ),
      )
          .then(
        (value) {
          value.user!.updateEmail(newEmail);
        },
      );
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
        plugin: 'flutter_error/server_error.updateEmail',
      );
    }
  }

  // Update user password
  Future<void> updatePassword(String password) async {
    try {
      // Get current user
      final fbAuth.User? currentUser = firebaseAuth.currentUser;
      // Update user password in firebase auth
      await currentUser!.updatePassword(password);
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
        plugin: 'flutter_error/server_error.updatePassword',
      );
    }
  }

  // Forgot password method
  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
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
        plugin: 'flutter_error/server_error.forgotPassword',
      );
    }
  }

  // verify email
  Future<void> verifyEmail() async {
    try {
      // Get current user
      final fbAuth.User? currentUser = firebaseAuth.currentUser;
      // Update user password in firebase auth
      await currentUser!.sendEmailVerification();
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
        plugin: 'flutter_error/server_error.verifyEmail',
      );
    }
  }
}
