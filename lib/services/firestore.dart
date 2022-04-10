import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/date_methods.dart';
import 'authentication.dart';

class FirestoreMethods {
  DateMethods date = DateMethods();
  // 「あなた」ページのデータ一覧
  getYourChatData() {
    return FirebaseFirestore.instance.collection("yourRoom").orderBy("createdAt", descending: false).snapshots();
  }

  // 「あなた」ページのデータ保存
  Future<void> storeYourChat(String text) async {
    final user = await getLoggedInUser();
    await FirebaseFirestore.instance.collection('reviewList').add({
      'uid': user.uid,
      'text': text,
      'createAt': date.now,
    });
  }
}
