import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/views/home_screen/home.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed successfully");
                    Get.offAll(const Home());
                  },
                  color: blueColor,
                  textColor: whiteColor,
                  title: "Place my order",
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.00),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePayemntIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? blueColor
                                : Colors.transparent,
                            width: 4)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMethodImg[index],
                        width: double.infinity,
                        height: 120,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: "${paymentMethods[index]}"
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make()),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
