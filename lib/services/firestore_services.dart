import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';

class FirestoreServices {
  //get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where("id", isEqualTo: uid)
        .snapshots();
  }

  //get products according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get products according to subcategory
  static getsubCategoryProducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  //get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete cart items
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get orders
  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //get wishlists
  static getWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  //get messages
  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //get Counts
  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  //get all products
  static allproducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  //get Featured products
  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('isFeatured', isEqualTo: true)
        .get();
  }

  //get searched products
  static searchProducts(title) {
    return firestore.collection(productsCollection).get();
  }
}
