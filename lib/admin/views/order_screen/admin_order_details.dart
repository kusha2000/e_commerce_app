import 'package:e_commerce_app/admin/const/colors.dart';
import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/controllers/admin_orders_controller.dart';
import 'package:e_commerce_app/admin/views/order_screen/components/admin_order_placed.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/admin/views/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class AdminOrderDetails extends StatefulWidget {
  final dynamic data;
  const AdminOrderDetails({super.key, this.data});

  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  var controller = Get.find<AdminOrderController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delevery'];
    controller.delivered.value = widget.data['order_deliverd'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
                color: greenColor,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: "order_confirmed",
                      status: true,
                      docID: widget.data.id);
                },
                title: "Confirm Order"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order delivery status section
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(
                          text: "Order status", color: fontGrey, size: 16.0),
                      SwitchListTile(
                        activeColor: greenColor,
                        value: true,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: greenColor,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: greenColor,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value = value;
                          controller.changeStatus(
                              title: "order_on_delevery",
                              status: value,
                              docID: widget.data.id);
                        },
                        title: boldText(text: "on Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: greenColor,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeStatus(
                              title: "order_deliverd",
                              status: value,
                              docID: widget.data.id);
                        },
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
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping method"),
                    orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format(widget.data['order_date'].toDate()),
                        d2: widget.data['payment_method'],
                        title1: "Order Date",
                        title2: "Payment method"),
                    orderPlaceDetails(
                        d1: "Unpaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery method"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Shipping Address",
                                  color: darkFontGrey),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_phone']}".text.make(),
                              "${widget.data['order_by_postalcode']}"
                                  .text
                                  .make(),
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
                                boldText(
                                    text: "Rs.${widget.data['total_amount']}",
                                    color: redColor),
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
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1: "${controller.orders[index]['title']}",
                          title2: "Rs.${controller.orders[index]['tprice']}",
                          d1: "${controller.orders[index]['qty']}x",
                          d2: "Refundable",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(controller.orders[index]['color']),
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
      ),
    );
  }
}
