// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petmarket_bo_app/constants/db_constant.dart';
import 'package:petmarket_bo_app/models/cart_item_model.dart';

import '../models/custom_error.dart';
import '../models/product_model.dart';
import '../models/shopping_cart_model.dart';

class ShoppingCartRepository {
  final FirebaseFirestore firebaseFirestore;

  ShoppingCartRepository({
    required this.firebaseFirestore,
  });

  // Stream of shopping cart items using listen
  Stream<List<CartItem>> get cartItemStream => usersRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('shopping_cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('product_items')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => CartItem.fromDoc(doc)).toList();
      });

  // Get shopping cart
  Future<ShoppingCart> getShoppingCart() async {
    try {
      final DocumentSnapshot shoppingCartDoc = await firebaseFirestore
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('shopping_cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (shoppingCartDoc.exists) {
        final currentShoppingCart = ShoppingCart.fromDoc(shoppingCartDoc);
        return currentShoppingCart;
      }

      throw 'Shopping cart not found';
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
        plugin: 'flutter_error/server_error.getShoppingCart',
      );
    }
  }

/*
  Add to shopping cart using try-catch and checking if the product is already in the cart
  the shopping cart collection contains only one document
  the document contains one collection of product items
  if the product is already in the cart, then update the quantity
  if the product is not in the cart, then add the product to the cart

*/
  Future<void> addToCart(Product product) async {
    try {
      final shoppingCartDoc = await usersRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('shopping_cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('product_items');

      // reference to document
      final productItemDoc = await shoppingCartDoc.doc(product.id).get();

      // check if the product is already in the cart
      if (productItemDoc.exists) {
        // update the quantity
        await shoppingCartDoc.doc(product.id).update({
          'quantity': productItemDoc['quantity'] + 1,
        });
      } else {
        // add the product to the cart
        await shoppingCartDoc.doc(product.id).set({
          'id': product.id,
          'name': product.name,
          'price': product.price,
          'quantity': 1,
          'image': product.image,
          'weight': product.weight,
          'stock': product.stock,
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
        plugin: 'flutter_error/server_error.addToCart',
      );
    }
  }

  // Remove from shopping cart
  Future<void> removeFromCart(Product product) async {
    try {
      final shoppingCartDoc = await usersRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('shopping_cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('product_items');

      // reference to document
      final productItemDoc = await shoppingCartDoc.doc(product.id).get();

      // check if the product is already in the cart
      if (productItemDoc.exists) {
        // update the quantity
        if (productItemDoc['quantity'] == 1) {
          await shoppingCartDoc.doc(product.id).delete();
          return;
        }
        await shoppingCartDoc.doc(product.id).update({
          'quantity': productItemDoc['quantity'] - 1,
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
        plugin: 'flutter_error/server_error.removeFromCart',
      );
    }
  }

  // Clear shopping cart
  Future<void> clearCart() async {
    try {
      final shoppingCartDoc = await firebaseFirestore
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('shopping_cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('product_items')
          .get();

      if (shoppingCartDoc.docs.isNotEmpty) {
        for (final doc in shoppingCartDoc.docs) {
          await doc.reference.delete();
        }
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
        plugin: 'flutter_error/server_error.clearCart',
      );
    }
  }

  // Get list of shopping cart items
  Future<List<CartItem>> getCartItems() async {
    List<CartItem> cartItems = [];

    try {
      final shoppingCartDoc = await firebaseFirestore
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('shopping_cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('product_items')
          .get();

      if (shoppingCartDoc.docs.isNotEmpty) {
        cartItems = shoppingCartDoc.docs.map((doc) => CartItem.fromDoc(doc)).toList();
      }
      return cartItems;
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
        plugin: 'flutter_error/server_error.getCartItems',
      );
    }
  }
}
