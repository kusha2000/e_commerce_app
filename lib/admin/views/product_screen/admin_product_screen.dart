import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/controllers/admin_products_controller.dart';
import 'package:e_commerce_app/admin/services/store_services.dart';
import 'package:e_commerce_app/admin/views/product_screen/admin_add_product.dart';
import 'package:e_commerce_app/admin/views/product_screen/admin_product_details.dart';
import 'package:e_commerce_app/admin/views/widgets/appbar_widget.dart';
import 'package:e_commerce_app/admin/views/widgets/loadingIndicator.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class AdminProductScreen extends StatelessWidget {
  const AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminProductController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => const AdminAddProduct());
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: appbarWidget(products),
      body: StreamBuilder(
          stream: StoreServices.getProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        data.length,
                        (index) => Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() =>
                                      AdminProductDetails(data: data[index]));
                                },
                                leading: Image.network(
                                  data[index]['p_imgs'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: fontGrey),
                                subtitle: Row(
                                  children: [
                                    normalText(
                                        text: "Rs.${data[index]['p_price']}",
                                        color: fontGrey),
                                    10.widthBox,
                                    boldText(
                                        text: data[index]['isFeatured'] == true
                                            ? "Featured"
                                            : " ",
                                        color: greenColor)
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                  arrowSize: 0.0,
                                  menuBuilder: () => Column(
                                    children: List.generate(
                                      popupMenuTitles.length,
                                      (i) => Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              popupMenuIcons[i],
                                              color: data[index]
                                                              ['featured_id'] ==
                                                          'jR4sp2Cpujg2A5i4YIXNbvXoFQ23' &&
                                                      i == 0
                                                  ? greenColor
                                                  : darkFontGrey,
                                            ),
                                            10.widthBox,
                                            normalText(
                                                text: data[index][
                                                                'featured_id'] ==
                                                            'jR4sp2Cpujg2A5i4YIXNbvXoFQ23' &&
                                                        i == 0
                                                    ? 'Remove feature'
                                                    : popupMenuTitles[i],
                                                color: darkFontGrey)
                                          ],
                                        ).onTap(() {
                                          switch (i) {
                                            case 0:
                                              if (data[index]['isFeatured'] ==
                                                  true) {
                                                controller.removeFeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Removed");
                                              } else {
                                                controller.addFeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Added");
                                              }
                                              break;
                                            case 1:
                                              break;
                                            case 2:
                                              controller.removeProduct(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg: "Product removed");
                                              break;
                                            default:
                                          }
                                        }),
                                      ),
                                    ),
                                  ).box.white.rounded.width(200).make(),
                                  clickType: VxClickType.singleClick,
                                  child: const Icon(Icons.more_vert_rounded),
                                ),
                              ),
                            )),
                  ),
                ),
              );
            }
          }),
    );
  }
}
