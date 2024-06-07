import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/product_screen/components/admin_product_dropdown.dart';
import 'package:e_commerce_app/admin/views/product_screen/components/admin_product_images.dart';
import 'package:e_commerce_app/admin/views/widgets/custom_textfield.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class AdminAddProduct extends StatelessWidget {
  const AdminAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          TextButton(
              onPressed: () {}, child: boldText(text: save, color: whiteColor))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customtextField(hint: "eg. BMW", label: "Product name"),
              10.heightBox,
              customtextField(
                  hint: "eg. Nice product", label: "Description", isDesc: true),
              10.heightBox,
              customtextField(hint: "eg. Rs.5000.00", label: "Price"),
              10.heightBox,
              customtextField(hint: "eg. Rs.5000.00", label: "Price"),
              10.heightBox,
              customtextField(hint: "eg. 20", label: "Quantity"),
              10.heightBox,
              adminProductDropdown(),
              10.heightBox,
              adminProductDropdown(),
              10.heightBox,
              const Divider(
                color: whiteColor,
              ),
              boldText(text: "Choose product images"),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    3, (index) => adminProductImages(label: "${index + 1}")),
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
              Wrap(
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
                                .make(),
                            const Icon(
                              Icons.done,
                              color: whiteColor,
                            )
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
