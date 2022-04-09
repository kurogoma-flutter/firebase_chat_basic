import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/date_methods.dart';

class FirestoreMethods {
  DateMethods date = DateMethods();
  // 「あなた」ページのデータ一覧
  getYourChatData() {
    return FirebaseFirestore.instance.collection("yourRoom").orderBy("createdAt", descending: false).snapshots();
  }

  // 「あなた」ページのデータ保存
  Future<void> storeYourChat(String text) async {
    await FirebaseFirestore.instance.collection('reviewList').add({
      'uid': 'UID',
      'text': text,
      'createAt': date.now,
    });
  }

  // ログインユーサーの情報を取得
  Future getLoggedInUser() async {}
}
