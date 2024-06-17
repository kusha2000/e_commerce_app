import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/views/cart_screen/shipping_screen.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
            height: 60,
            child: ourButton(
                color: blueColor,
                onPress: () {
                  Get.to(() => const ShippingDetails());
                },
                textColor: whiteColor,
                title: "Proceed to shipping")),
        backgroundColor: whiteColor,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: "Shopping cart"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is Empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network("${data[index]['img']}",
                                    width: 80, fit: BoxFit.cover),
                                title:
                                    "${data[index]['title']} (x${data[index]['qty']})"
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                subtitle: "Rs.${data[index]['tprice']}.00"
                                    .text
                                    .fontFamily(semibold)
                                    .color(blueColor)
                                    .size(16)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: blueColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "Rs.${controller.totalP.value}.00"
                                .text
                                .fontFamily(semibold)
                                .color(blueColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightGolden)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}
