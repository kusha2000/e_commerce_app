import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/admin/const/admin_firebase_conts.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController {
  var orders = [];

  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == "jR4sp2Cpujg2A5i4YIXNbvXoFQ23") {
        orders.add(item);
      }
    }
  }

  changeStatus({title, status, docID}) async {
    var store = firestore.collection(orderCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
