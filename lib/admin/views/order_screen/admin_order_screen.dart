import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/appbar_widget.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarWidget(orders),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20,
                (index) => ListTile(
                      onTap: () {},
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "8212132132131231231", color: purpleColor),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, color: fontGrey),
                              10.widthBox,
                              boldText(
                                  text: intl.DateFormat()
                                      .add_yMd()
                                      .format(DateTime.now()),
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
                          text: "\Rs.4000.0", color: purpleColor, size: 16.0),
                    ).box.margin(EdgeInsets.only(bottom: 4)).make()),
          ),
        ),
      ),
    );
  }
}
