import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/services/store_services.dart';
import 'package:e_commerce_app/admin/views/message_screen/admin_chat_screen.dart';
import 'package:e_commerce_app/admin/views/widgets/loadingIndicator.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class AdminMessageScreen extends StatelessWidget {
  const AdminMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
          stream: StoreServices.getMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['created_on'] == null
                          ? DateTime.now()
                          : data[index]['created_on'].toDate();
                      var time = intl.DateFormat("h:mma").format(t);
                      return ListTile(
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
                        title: boldText(
                            text: "${data[index]['sender_name']}",
                            color: fontGrey),
                        subtitle: normalText(
                            text: "${data[index]['last_msg']}",
                            color: darkFontGrey),
                        trailing: normalText(text: time, color: darkFontGrey),
                      );
                    }),
                  ),
                ),
              );
            }
          }),
      // body:
    );
  }
}
