import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/views/orders_screen/orders_details.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title:
              "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllOrders(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "No orders yet!".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: "${index + 1}"
                            .text
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .xl
                            .make(),
                        title: data[index]['order_code']
                            .toString()
                            .text
                            .color(blueColor)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: data[index]['total_amount']
                            .toString()
                            .numCurrency
                            .text
                            .fontFamily(bold)
                            .make(),
                        trailing: IconButton(
                          onPressed: () {
                            // Get.to(() => OrdersDetails(data: data,));
                            Get.to(() => OrdersDetails(
                                  data: data[index],
                                ));
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          color: darkFontGrey,
                        ),
                      );
                    });
              }
            }));
  }
}
