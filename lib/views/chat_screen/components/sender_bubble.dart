// sender_bubble.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

class SenderBubble extends StatelessWidget {
  final DocumentSnapshot data;

  const SenderBubble({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserUid = currentUser!.uid;
    final bool isCurrentUserMessage = data['uid'] == currentUserUid;

    DateTime t = data['created_on'] == null
        ? DateTime.now()
        : data['created_on'].toDate();
    var time = intl.DateFormat("h:mma").format(t);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isCurrentUserMessage ? blueColor : darkFontGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data['msg']}",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            time, // Add time here or any other additional information
            style: TextStyle(color: whiteColor.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
