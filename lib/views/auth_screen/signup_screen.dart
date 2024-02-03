import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets_common/applogo_widget.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:e_commerce_app/widgets_common/custom_textfield.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? ischecked = false;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(
              children: [
                customTextField(hint: nameHint, title: name),
                customTextField(hint: emailHint, title: email),
                customTextField(hint: passwordHint, title: password),
                customTextField(hint: passwordHint, title: retypePassword),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: forgetPass.text.make()),
                ),
                // ourButton().box.width(context.screenWidth - 50).make(),

                Row(
                  children: [
                    Checkbox(
                      checkColor: redColor,
                      value: ischecked,
                      onChanged: (newValue) {
                        setState(() {
                          ischecked = newValue;
                        });
                      },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: termAndCond,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          ),
                          TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
                ourButton(
                        color: ischecked == true ? redColor : lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: () {})
                    .box
                    .width(context.screenWidth - 50)
                    .make(),

                10.heightBox,
                //wrapping into gesture detector of velocity x
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: alreadyHaveAccount,
                      style: TextStyle(
                        fontFamily: bold,
                        color: fontGrey,
                      ),
                    ),
                    TextSpan(
                      text: login,
                      style: TextStyle(
                        fontFamily: bold,
                        color: redColor,
                      ),
                    ),
                  ]),
                ).onTap(() {
                  Get.back();
                }),
              ],
            )
                .box
                .white
                .rounded
                .padding(EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ]),
        ),
      ),
    );
  }
}
