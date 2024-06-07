import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/message_screen/admin_message_screen.dart';
import 'package:e_commerce_app/admin/views/profile_screen/admin_edit_profilescreen.dart';
import 'package:e_commerce_app/admin/views/shop_screnn/admin_shop_settings_screen.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AdminEditProfileScreen());
            },
            icon: const Icon(Icons.edit),
            color: whiteColor,
          ),
          TextButton(onPressed: () {}, child: normalText(text: logout))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Image.asset(imgProduct)
                .box
                .roundedFull
                .clip(Clip.antiAlias)
                .make(),
            title: boldText(text: "vendor name"),
            subtitle: normalText(text: "vendoremail@eshop.lk"),
          ),
          Divider(),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(
                  profileButtonTitles.length,
                  (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const AdminShopSettings());
                            case 1:
                              Get.to(() => const AdminMessageScreen());
                          }
                        },
                        leading: Icon(
                          profileButtonIcons[index],
                          color: whiteColor,
                        ),
                        title: normalText(text: profileButtonTitles[index]),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
