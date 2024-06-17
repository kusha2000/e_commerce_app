// chat_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/controllers/chat_controller.dart';
import 'package:e_commerce_app/views/chat_screen/components/sender_bubble.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: controller.friendName.text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: loadingIndicator());
              } else {
                return Expanded(
                  child: StreamBuilder(
                    stream: controller.getChatMessages(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: loadingIndicator());
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text("Send a message...",
                                style: TextStyle(color: darkFontGrey)));
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return Align(
                                alignment: document['uid'] == currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: SenderBubble(data: document));
                          }).toList(),
                        );
                      }
                    },
                  ),
                );
              }
            }),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      hintText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(Icons.send, color: blueColor),
                ),
              ],
            )
                .box
                .height(60)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
