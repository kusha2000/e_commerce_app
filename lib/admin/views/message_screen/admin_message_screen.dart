import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/message_screen/admin_chat_screen.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMessageScreen extends StatelessWidget {
  const AdminMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: List.generate(
              20,
              (index) => ListTile(
                    onTap: () {
                      Get.to(() => AdminChatScreen());
                    },
                    leading: const CircleAvatar(
                      backgroundColor: purpleColor,
                      child: Icon(
                        Icons.person,
                        color: whiteColor,
                      ),
                    ),
                    title: boldText(text: "Username", color: fontGrey),
                    subtitle: normalText(
                        text: "last message...", color: darkFontGrey),
                    trailing: normalText(text: "10.45PM", color: darkFontGrey),
                  )),
        ),
      ),
    );
  }
}
