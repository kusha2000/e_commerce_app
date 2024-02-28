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

  //get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //get cart
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
        .where('p_wishlist', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //get messages
  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }
}
