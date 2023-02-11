// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/db_constant.dart';
import '../models/brand_model.dart';
import '../models/custom_error.dart';

class BrandRepository {
  final FirebaseFirestore firebaseFirestore;
  BrandRepository({
    required this.firebaseFirestore,
  });

  // Stream of brand list
  Stream<List<Brand>> get brandListStream => brandsRef.snapshots().map((brandList) {
        return brandList.docs.map((brandDoc) => Brand.fromJson(brandDoc)).toList();
      });

  // get brand list
  Future<List<Brand>> getBrandList() async {
    try {
      final QuerySnapshot brandList = await brandsRef.get();
      if (brandList.docs.isNotEmpty) {
        final brandListData = brandList.docs.map((brandDoc) => Brand.fromJson(brandDoc)).toList();
        return brandListData;
      }
      throw 'Brand not found';
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
        plugin: 'flutter_error/server_error.getBrandList',
      );
    }
  }
}
