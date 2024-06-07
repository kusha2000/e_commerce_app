import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/controllers/admin_products_controller.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget adminProductDropdown(
    hint, List<String> list, dropvalue, AdminProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          hint: normalText(text: hint, color: fontGrey),
          value: dropvalue.value == '' ? null : dropvalue.value,
          isExpanded: true,
          items: list.map((e) {
            return DropdownMenuItem<String>(
                value: e, child: normalText(text: e, color: fontGrey));
          }).toList(),
          onChanged: (newValue) {
            if (hint == "Category") {
              controller.subcategoryvalues.value = '';
              controller.populateSubcategoryList(newValue.toString());
            }
            dropvalue.value = newValue.toString();
          }),
    )
        .box
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .roundedSM
        .make(),
  );
}
