import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AdminProductController extends GetxController {
  var isloading = false.obs;
  // text field controllers
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalues = ''.obs;
  var subcategoryvalues = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    categoryList.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubcategoryList(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination =
            'images/vendors/jR4sp2Cpujg2A5i4YIXNbvXoFQ23/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'isFeatured': false,
      'p_category': categoryvalues.value,
      'p_subcategory': subcategoryvalues.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.brown.value]),
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_seller': 'Kushan Manethra',
      'p_rating': "5.0",
      'vendor_id': 'jR4sp2Cpujg2A5i4YIXNbvXoFQ23',
      'featured_id': 'jR4sp2Cpujg2A5i4YIXNbvXoFQ23'
    });
    isloading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "featured_id": "jR4sp2Cpujg2A5i4YIXNbvXoFQ23",
      "isFeatured": true,
    }, SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "featured_id": "",
      "isFeatured": false,
    }, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }
}
