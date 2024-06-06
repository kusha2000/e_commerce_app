import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/custom_textfield.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';

class AdminEditProfileScreen extends StatelessWidget {
  const AdminEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: editprofile, size: 16.0),
        actions: [TextButton(onPressed: () {}, child: normalText(text: save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(imgProduct, width: 150)
                .box
                .roundedFull
                .clip(Clip.antiAlias)
                .make(),
            10.heightBox,
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: whiteColor),
                onPressed: () {},
                child: normalText(text: changeImage, color: fontGrey)),
            10.heightBox,
            const Divider(
              color: whiteColor,
            ),
            customtextField(label: name, hint: "eg. Kushan"),
            10.heightBox,
            customtextField(label: password, hint: passwordHint),
            10.heightBox,
            customtextField(label: confirmPass, hint: passwordHint),
          ],
        ),
      ),
    );
  }
}
