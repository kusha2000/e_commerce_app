import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/product_screen/components/admin_product_dropdown.dart';
import 'package:e_commerce_app/admin/views/product_screen/components/admin_product_images.dart';
import 'package:e_commerce_app/admin/views/widgets/custom_textfield.dart';
import 'package:e_commerce_app/admin/views/widgets/loadingIndicator.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/admin/controllers/admin_products_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdminAddProduct extends StatelessWidget {
  const AdminAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminProductController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: purpleColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkFontGrey,
              )),
          title: boldText(text: "Add Product", color: whiteColor, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: whiteColor)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: save, color: whiteColor))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customtextField(
                    hint: "eg. BMW",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customtextField(
                    hint: "eg. Nice product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customtextField(
                    hint: "eg. Rs.5000.00",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customtextField(
                    hint: "eg. 20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                adminProductDropdown("Category", controller.categoryList,
                    controller.categoryvalues, controller),
                10.heightBox,
                adminProductDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalues, controller),
                10.heightBox,
                const Divider(
                  color: whiteColor,
                ),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index],
                              width: 100,
                              height: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : adminProductImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
                10.heightBox,
                const Divider(
                  color: whiteColor,
                ),
                boldText(text: "Choose product colors"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        9,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(Vx.randomPrimaryColor)
                                    .roundedFull
                                    .size(50, 50)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: whiteColor,
                                      )
                                    : const SizedBox(),
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
