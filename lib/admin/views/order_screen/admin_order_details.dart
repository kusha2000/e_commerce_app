import 'package:e_commerce_app/admin/const/colors.dart';
import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/order_screen/components/admin_order_placed.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/admin/views/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class AdminOrderDetails extends StatelessWidget {
  const AdminOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkFontGrey,
            )),
        title: boldText(text: "Order Details", size: 16.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth,
        child: ourButton(
            color: greenColor, onPress: () {}, title: "Confirm Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //order delivery status section
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: "Order status", color: fontGrey, size: 16.0),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: "Placed", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: "Confirmed", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: false,
                      onChanged: (value) {},
                      title: boldText(text: "on Delivery", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: false,
                      onChanged: (value) {},
                      title: boldText(text: "Deliverd", color: fontGrey),
                    ),
                  ],
                )
                    .box
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
              ),

              //order details section
              Column(
                children: [
                  orderPlaceDetails(
                      d1: "data['order_code']",
                      d2: "data['shipping_method']",
                      title1: "Order Code",
                      title2: "Shipping method"),
                  orderPlaceDetails(
                      d1: DateTime.now(),
                      d2: "data['shipping_method']",
                      title1: "Order Code",
                      title2: "Shipping method"),
                  orderPlaceDetails(
                      d1: DateTime.now(),
                      d2: "data['payment_method']",
                      title1: "Order Date",
                      title2: "Payment method"),
                  orderPlaceDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery method"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            // "{data['order_by_name']}".text.make(),
                            // "{data['order_by_email']}".text.make(),
                            // "{data['order_by_address']}".text.make(),
                            // "{data['order_by_city']}".text.make(),
                            // "{data['order_by_state']}".text.make(),
                            // "{data['order_by_phone']}".text.make(),
                            // "{data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Total Amount", color: purpleColor),
                              boldText(text: "Rs.300", color: redColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  .box
                  .outerShadowMd
                  .white
                  .border(color: lightGrey)
                  .roundedSM
                  .make(),
              const Divider(),
              10.heightBox,
              boldText(text: "Ordered products", color: purpleColor),
              ListView(
                shrinkWrap: true,
                children: List.generate(3, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: "data['orders'][index]['title']",
                        title2: "data['orders'][index]['tprice']",
                        d1: "{data['orders'][index]['qty']}x",
                        d2: "Refundable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: purpleColor,
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
