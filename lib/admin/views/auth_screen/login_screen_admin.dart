import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/controllers/admin_auth_controller.dart';
import 'package:e_commerce_app/admin/views/home_screen/admin_home.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/admin/views/widgets/loadingIndicator.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreenAdmin extends StatelessWidget {
  const LoginScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminAuthController());
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

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
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: emailController,
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
                      obscureText: true,
                      controller: passwordController,
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
                      child: controller.isloading.value
                          ? loadingIndicator()
                          : ourButton(
                              title: login,
                              onPress: () async {
                                if (emailController.text == "admin@gmail.com" &&
                                    passwordController.text == "123456") {
                                  Get.to(() => const AdminHome());
                                } else {
                                  VxToast.show(context,
                                      msg: "Wrong username and password");
                                }

                                // controller.isloading(true);
                                // await controller
                                //     .loginMethod(context: context)
                                //     .then((value) {
                                //   if (value != null) {
                                //     VxToast.show(context, msg: "Logged in");
                                //     controller.isloading(false);
                                //     Get.offAll(() => const AdminHome());
                                //     //Get.to(() => AdminHome());
                                //   } else {
                                //     controller.isloading(false);
                                //   }
                                // });
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
              ),
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
