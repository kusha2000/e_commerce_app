import 'package:e_commerce_app/admin/const/admin_firebase_conts.dart';

class StoreServices {
  static getMessages() {
    return firestore
        .collection(chatsCollection)
        .where("toId", isEqualTo: "jR4sp2Cpujg2A5i4YIXNbvXoFQ23")
        .snapshots();
  }

  static getOrders() {
    return firestore
        .collection(orderCollection)
        .where("vendors", arrayContains: "jR4sp2Cpujg2A5i4YIXNbvXoFQ23")
        .snapshots();
  }

  static getProducts() {
    return firestore
        .collection(productsCollection)
        .where("vendor_id", isEqualTo: "jR4sp2Cpujg2A5i4YIXNbvXoFQ23")
        .snapshots();
  }

  //If use user id without manuualy
  // static getProducts(uid) {
  //   return firestore
  //       .collection(productsCollection)
  //       .where("vendor_id", isEqualTo: uid)
  //       .snapshots();
  // }

  static getPopularProducts() {
    return firestore
        .collection(productsCollection)
        .where("vendor_id", isEqualTo: "jR4sp2Cpujg2A5i4YIXNbvXoFQ23")
        .orderBy('p_wishlist'.length);
  }
}
