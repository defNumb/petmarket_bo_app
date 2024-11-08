// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petmarket_bo_app/constants/db_constant.dart';
import 'package:petmarket_bo_app/models/custom_error.dart';
import 'package:petmarket_bo_app/models/pet_model.dart';

class PetRepository {
  final FirebaseFirestore firebaseFirestore;

  PetRepository({
    required this.firebaseFirestore,
  });

  // Stream of pet list
  Stream<List<Pet>> get petListStream => usersRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('pets')
          .snapshots()
          .map((petList) {
        return petList.docs.map((petDoc) => Pet.fromDoc(petDoc)).toList();
      });

  // Get pet profile
  Future<Pet> getPetProfile({required String pid}) async {
    // get current user id
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      final DocumentSnapshot petDoc = await usersRef.doc(uid).collection('pets').doc(pid).get();
      if (petDoc.exists) {
        final currentPet = Pet.fromDoc(petDoc);
        return currentPet;
      }
      throw 'Pet not found';
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
        plugin: 'flutter_error/server_error.getPetProfile',
      );
    }
  }

  // Get pet list
  Future<List<Pet>> getPetList({required String uid}) async {
    try {
      final QuerySnapshot petList = await usersRef.doc(uid).collection('pets').get();
      if (petList.docs.isNotEmpty) {
        final petListData = petList.docs.map((petDoc) => Pet.fromDoc(petDoc)).toList();
        return petListData;
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
        plugin: 'flutter_error/server_error ref.GetPetList',
      );
    }
  }

  // Add pet
  Future<void> createPet(Pet pet, String uid) async {
    try {
      final petDoc = await usersRef.doc(uid).collection('pets');
      var randomDoc = petDoc.doc();
      await petDoc.doc(randomDoc.id).set(
        {
          'id': randomDoc.id,
          'name': pet.name,
          'icon': pet.icon,
          'species': pet.species,
          'breed': pet.breed,
          'breed2': pet.breed2,
          'gender': pet.gender,
          'birthDay': pet.birthDay,
          'weight': pet.weight,
          'healthConditions': pet.healthConditions,
          'neutered': pet.neutered,
          'backgroundImage': pet.backgroundImage,
          'referenceId': uid,
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
        plugin: 'flutter_error/server_error.createPet',
      );
    }
  }

  // Update pet
  Future updatePet(Pet pet) async {
    try {
      final petDoc =
          await usersRef.doc(FirebaseAuth.instance.currentUser!.uid).collection('pets').doc(pet.id);

      await petDoc.update({
        'id': pet.id,
        'name': pet.name,
        'icon': pet.icon,
        'species': pet.species,
        'breed': pet.breed,
        'breed2': pet.breed2,
        'birthday': pet.birthDay,
        'weight': pet.weight,
        'healthConditions': pet.healthConditions,
        'neutered': pet.neutered,
        'background': pet.backgroundImage
      });
      throw 'Oops try again!';
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
        plugin: 'flutter_error/server_error.updatePet',
      );
    }
  }

  // Delete pet
  Future deletePet({required String uid, required String pid}) async {
    try {
      final petDoc = await usersRef.doc(uid).collection('pets').doc(pid);
      await petDoc.delete();
      throw 'Oops try again!';
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
        plugin: 'flutter_error/server_error.deletePet',
      );
    }
  }
}
