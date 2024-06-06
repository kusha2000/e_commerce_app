import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/home_screen/admin_home.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreenAdmin extends StatelessWidget {
  const LoginScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 80,
                    height: 80,
                  )
                      .box
                      .border(color: whiteColor)
                      .rounded
                      .padding(EdgeInsets.all(8.0))
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 18.0),
                ],
              ),
              40.heightBox,
              normalText(text: loginTo, size: 18.0, color: lightGrey),
              10.heightBox,
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: emailHint),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: passwordHint),
                  ),
                  10.heightBox,
                  30.heightBox,
                  SizedBox(
                    width: context.screenWidth - 100,
                    child: ourButton(
                        title: login,
                        onPress: () {
                          Get.to(() => const AdminHome());
                        }),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .outerShadowMd
                  .padding(EdgeInsets.all(8.0))
                  .make(),
              10.heightBox,
              Center(child: normalText(text: anyProblem)),
              Spacer(),
              Center(child: boldText(text: credit))
            ],
          ),
        ),
      ),
    );
  }
}
