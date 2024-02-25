import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/controllers/profile_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/views/auth_screen/login_screen.dart';
import 'package:e_commerce_app/views/profile_screen/components/details_cart.dart';
import 'package:e_commerce_app/views/profile_screen/edit_profile.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ));
                } else {
                  var data = snapshot.data!.docs[0];
                  return SafeArea(
                    child: Column(
                      children: [
                        //edit profile button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.edit,
                              color: whiteColor,
                            ),
                          ).onTap(() {
                            controller.nameController.text = data['name'];
                            controller.passController.text = data['password'];
                            Get.to(() => EditProfileScreen(data: data));
                          }),
                        ),

                        //user details section
                        Row(
                          children: [

                            data['imageUrl']=='' 

                            ? Image.asset(imgProfile2,
                                    width: 80, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imageUrl'],
                                    width: 80, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                  color: whiteColor,
                                )),
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signoutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text
                                    .fontFamily(semibold)
                                    .white
                                    .make())
                          ],
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: "${data['card_count']}",
                                title: "in your cart",
                                width: context.screenWidth / 3.5),
                            detailsCard(
                                count: "${data['wishlist_count']}",
                                title: "in your wishlist",
                                width: context.screenWidth / 3.5),
                            detailsCard(
                                count: "${data['order_count']}",
                                title: "your orders",
                                width: context.screenWidth / 3.5),
                          ],
                        ),

                        //button section

                        ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemCount: profileButtonList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Image.asset(
                                        profileButtonIcon[index],
                                        width: 22),
                                    title: profileButtonList[index]
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                  );
                                })
                            .box
                            .white
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make(),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}