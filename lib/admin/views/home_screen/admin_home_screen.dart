import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/product_screen/admin_product_details.dart';
import 'package:e_commerce_app/admin/views/widgets/appbar_widget.dart';
import 'package:e_commerce_app/admin/views/widgets/dashboard_button.dart';
import 'package:e_commerce_app/admin/views/widgets/loadingIndicator.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/admin/services/store_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreServices
            .getProducts(), //if we use current user when login use getorder(currentUser!.uid)
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: products,
                          count: "${data.length}",
                          icon: icProducts),
                      dashboardButton(context,
                          title: orders, count: "15", icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: rating, count: "60", icon: icStar),
                      dashboardButton(context,
                          title: totalSale, count: "15", icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  const Divider(),
                  10.heightBox,
                  boldText(text: popular, color: fontGrey, size: 16.0),
                  20.heightBox,
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      data.length,
                      (index) => data[index]['p_wishlist'].length == 0
                          ? const SizedBox()
                          : ListTile(
                              onTap: () {
                                Get.to(() =>
                                    AdminProductDetails(data: data[index]));
                              },
                              leading: Image.network(
                                data[index]["p_imgs"][0],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              title: boldText(
                                  text: "${data[index]["p_name"]}",
                                  color: fontGrey),
                              subtitle: normalText(
                                  text: "Rs.${data[index]["p_price"]}",
                                  color: darkFontGrey),
                            ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
