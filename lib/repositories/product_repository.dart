// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petmarket_bo_app/models/product_model.dart';

import '../constants/db_constant.dart';
import '../models/custom_error.dart';
import '../models/product_detail_model.dart';

class ProductRepository {
  final FirebaseFirestore firebaseFirestore;
  ProductRepository({
    required this.firebaseFirestore,
  });

  // Stream of product detail
  Stream<ProductDetail> getProductDetailStream({required String pid}) {
    return productsRef
        .doc(pid)
        .collection("product_details")
        .snapshots()
        .map((productDoc) => ProductDetail.fromDoc(productDoc));
  }

  // Stream of product list
  Stream<List<Product>> get productListStream => productsRef.snapshots().map((productList) {
        return productList.docs.map((productDoc) => Product.fromDoc(productDoc)).toList();
      });

  // get product profile
  Future<Product> getProductProfile({required String pid}) async {
    try {
      final DocumentSnapshot productDoc = await productsRef.doc(pid).get();
      if (productDoc.exists) {
        final currentProduct = Product.fromDoc(productDoc);
        return currentProduct;
      }
      throw 'Product not found';
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
        plugin: 'flutter_error/server_error.getProductProfile',
      );
    }
  }

  // get product list
  Future<List<Product>> getProductList() async {
    try {
      final QuerySnapshot productList = await productsRef.get();
      if (productList.docs.isNotEmpty) {
        final productListData =
            productList.docs.map((productDoc) => Product.fromDoc(productDoc)).toList();
        return productListData;
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
        plugin: 'flutter_error/server_error.getProductList',
      );
    }
  }

  // filter by category
  Future<List<Product>> filterByCategory({required String category}) async {
    try {
      final QuerySnapshot productList =
          await productsRef.where('category', isEqualTo: category).get();
      if (productList.docs.isNotEmpty) {
        final productListData =
            productList.docs.map((productDoc) => Product.fromDoc(productDoc)).toList();
        return productListData;
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
        plugin: 'flutter_error/server_error.filterByCategory',
      );
    }
  }

  // filter by subcategory
  Future<List<Product>> filterBySubCategory({required String subCategory}) async {
    try {
      final QuerySnapshot productList =
          await productsRef.where('sub_category', isEqualTo: subCategory).get();
      if (productList.docs.isNotEmpty) {
        final productListData =
            productList.docs.map((productDoc) => Product.fromDoc(productDoc)).toList();
        return productListData;
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
        plugin: 'flutter_error/server_error.filterBySubCategory',
      );
    }
  }

  // filter by animal
  Future<List<Product>> filterByAnimal({required String animal}) async {
    try {
      final QuerySnapshot productList = await productsRef.where('animal', isEqualTo: animal).get();
      if (productList.docs.isNotEmpty) {
        final productListData =
            productList.docs.map((productDoc) => Product.fromDoc(productDoc)).toList();
        return productListData;
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
        plugin: 'flutter_error/server_error.filterByAnimal',
      );
    }
  }

  // filter by brand
  Future<List<Product>> filterByBrand({required String brand}) async {
    try {
      final QuerySnapshot productList = await productsRef.where('brand', isEqualTo: brand).get();
      if (productList.docs.isNotEmpty) {
        final productListData =
            productList.docs.map((productDoc) => Product.fromDoc(productDoc)).toList();
        return productListData;
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
        plugin: 'flutter_error/server_error.filterByBrand',
      );
    }
  }

  // filter by animal and category
  Future<List<Product>> filterByAnimalAndCategory(
      {required String animal, required String category}) async {
    try {
      final QuerySnapshot productList = await productsRef
          .where('animal', isEqualTo: animal)
          .where('category', isEqualTo: category)
          .get();
      if (productList.docs.isNotEmpty) {
        final productListData =
            productList.docs.map((productDoc) => Product.fromDoc(productDoc)).toList();
        return productListData;
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
        plugin: 'flutter_error/server_error.filterByAnimalAndCategory',
      );
    }
  }
}
