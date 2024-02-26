import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/controllers/home_conroller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  //text controllers for shipping details

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];

  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP = totalP + int.parse(data[i]['tprice'].toString());
    }
  }

  changePayemntIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);

    await getProductDetails();

    await firestore.collection(orderCollection).doc().set({
      'order_code': "39232329892323",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': cityController.text,
      'order_by_postalcode': postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_deliverd': false,
      'order_on_delevery': false,
      'total_amount': totalAmount.value,
      'orders': FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vendor_id':productSnapshot[i]['vendor_id'],//this
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
    print(products);
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
