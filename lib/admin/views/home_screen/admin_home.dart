import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/controllers/admin_home_controller.dart';
import 'package:e_commerce_app/admin/views/home_screen/admin_home_screen.dart';
import 'package:e_commerce_app/admin/views/order_screen/admin_order_screen.dart';
import 'package:e_commerce_app/admin/views/product_screen/admin_product_screen.dart';
import 'package:e_commerce_app/admin/views/profile_screen/admin_profile_screen.dart';
import 'package:e_commerce_app/admin/views/settings_screen/admin_settings_screen.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminHomeController());
    var navScreens = [
      const AdminHomeScreen(),
      const AdminProductScreen(),
      const AdminOrderScreen(),
      const AdminProfileScreen()
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, color: darkFontGrey, width: 24),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, width: 24, color: darkFontGrey),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings, width: 24, color: darkFontGrey),
          label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkFontGrey,
            items: bottomNavbar),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
