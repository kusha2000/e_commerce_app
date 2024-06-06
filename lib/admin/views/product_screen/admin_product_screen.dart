import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/appbar_widget.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

class AdminProductScreen extends StatelessWidget {
  const AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: appbarWidget(products),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20,
                (index) => ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        imgProduct,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: boldText(text: "Product title", color: fontGrey),
                      subtitle: normalText(text: "Rs.4000.0", color: lightGrey),
                      trailing: VxPopupMenu(
                        arrowSize: 0.0,
                        menuBuilder: () => Column(
                          children: List.generate(
                            popupMenuTitles.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(popupMenuIcons[index]),
                                  10.widthBox,
                                  normalText(
                                      text: popupMenuTitles[index],
                                      color: darkFontGrey)
                                ],
                              ).onTap(() {}),
                            ),
                          ),
                        ).box.white.rounded.width(200).make(),
                        clickType: VxClickType.singleClick,
                        child: const Icon(Icons.more_vert_rounded),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
