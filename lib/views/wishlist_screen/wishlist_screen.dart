import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "My Wishlists"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getWishlists(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "No wishlists yet!".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                                "${data[index]['p_imgs'][0]}",
                                width: 80,
                                fit: BoxFit.cover),
                            title: "${data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "Rs.${data[index]['p_price']}.00"
                                .text
                                .fontFamily(semibold)
                                .color(blueColor)
                                .size(16)
                                .make(),
                            trailing: const Icon(
                              Icons.favorite,
                              color: blueColor,
                            ).onTap(() {
                              firestore
                                  .collection(productsCollection)
                                  .doc(data[index].id)
                                  .set({
                                'p_wishlist':
                                    FieldValue.arrayRemove([currentUser!.uid]),
                              }, SetOptions(merge: true));
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
