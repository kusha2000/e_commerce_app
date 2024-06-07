import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/controllers/admin_orders_controller.dart';
import 'package:e_commerce_app/admin/services/store_services.dart';
import 'package:e_commerce_app/admin/views/order_screen/admin_order_details.dart';
import 'package:e_commerce_app/admin/views/widgets/appbar_widget.dart';
import 'package:e_commerce_app/admin/views/widgets/loadingIndicator.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminOrderController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices
              .getOrders(), //if we use current user when login use getorder(currentUser!.uid)
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        onTap: () {
                          Get.to(() => AdminOrderDetails(data: data[index]));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: boldText(
                            text: "${data[index]['order_code']}",
                            color: purpleColor),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month,
                                    color: fontGrey),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.payment, color: fontGrey),
                                10.widthBox,
                                boldText(text: unpaid, color: redColor),
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "Rs.${data[index]['total_amount']}",
                            color: purpleColor,
                            size: 16.0),
                      ).box.margin(EdgeInsets.only(bottom: 4)).make();
                    }),
                  ),
                ),
              );
            }
          }),
    );
  }
}
