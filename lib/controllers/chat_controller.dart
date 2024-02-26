// chat_controller.dart
import 'package:e_commerce_app/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  var friendName = '';
  var friendId = '';
  var currentId = '';
  var chatDocId = '';

  var msgController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args.length >= 2) {
      friendName = args[0];
      friendId = args[1];
    }
    currentId = currentUser!.uid;
    getChatId();
    super.onInit();
  }

  getChatId() async {
    isLoading(true);
    try {
      final snapshot = await firestore
          .collection(chatsCollection)
          .where('users', isEqualTo: {friendId: null, currentId: null})
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        chatDocId = snapshot.docs.single.id;
      } else {
        final newChatDocRef = await firestore.collection(chatsCollection).add({
          'created_on': null,
          'last_msg': '',
          'users': {friendId: null, currentId: null},
          'toId': '',
          'fromId': '',
          'friend_name': friendName,
          'sender_name': currentUser!.displayName,
        });
        chatDocId = newChatDocRef.id;
      }
    } catch (error) {
      print("Error getting chat ID: $error");
    } finally {
      isLoading(false);
    }
  }

  //get all chat messages
  Stream<QuerySnapshot> getChatMessages() {
    return firestore
        .collection(chatsCollection)
        .doc(chatDocId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      await firestore.collection(chatsCollection).doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });
      await firestore
          .collection(chatsCollection)
          .doc(chatDocId)
          .collection(messagesCollection)
          .add({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
